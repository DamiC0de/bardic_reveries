class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscription_plans = SubscriptionPlan.where.not(name: 'default')
    @current_subscription = current_user.subscriptions.where('expiration_date > ?', Time.now).order(created_at: :desc).first
  end

  def checkout
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: @subscription_plan.stripe_price_id,
        quantity: 1,
      }],
      mode: 'payment', # Change 'subscription' to 'payment'
      success_url: subscriptions_url(success: true),
      cancel_url: subscriptions_url,
    )
    redirect_to @session.url, allow_other_host: true
  end

  def webhook
    begin
      event = Stripe::Webhook.construct_event(
        request.body.read,
        request.env['HTTP_STRIPE_SIGNATURE'],
        Rails.application.credentials.dig(:stripe, :webhook_secret)
      )
    rescue Stripe::SignatureVerificationError => e
      render json: {error: e.message}, status: 400
      return
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']

      user = User.find_by(stripe_customer_id: session['customer'])

      # Pour un achat unique, le prix pourrait être dans 'line_items' au lieu de 'display_items'.
      plan = SubscriptionPlan.find_by(stripe_price_id: session['line_items'].first['price']['id'])

      # Création de la nouvelle souscription
      subscription = Subscription.new(
        user: user, 
        subscription_plan: plan, 
        start_date: Time.now, 
        expiration_date: Time.now + plan.duration.days
      )

      if subscription.save
        # Création de la nouvelle commande
        order = Order.create(user: user, subscription: subscription)
        if order.save
          render json: {message: 'success'}, status: :ok
        else
          render json: {error: "Order creation failed: #{order.errors.full_messages.join(", ")}"}, status: :unprocessable_entity
        end
      else
        render json: {error: "Subscription creation failed: #{subscription.errors.full_messages.join(", ")}"}, status: :unprocessable_entity
      end
    end
  end
end
