class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscription_plans = SubscriptionPlan.where.not(name: 'default')
    @current_subscription = current_user.subscriptions.where('expiration_date > ?', Time.now).order(created_at: :desc).first
  end

  def checkout
    begin
      @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
      @session = Stripe::Checkout::Session.create(
        customer: current_user.stripe_customer_id,
        payment_method_types: ['card'],
        line_items: [{
          price: @subscription_plan.stripe_price_id,
          quantity: 1,
        }],
        mode: 'payment',
        success_url: subscriptions_url(success: true, host: request.host),
        cancel_url: subscriptions_url,
      )
      
      # Création de la nouvelle souscription
      subscription = Subscription.new(
        user: current_user, 
        subscription_plan: @subscription_plan, 
        start_date: Time.now, 
        expiration_date: Time.now + @subscription_plan.duration.days
      )
      
      if subscription.save
        # Création de la nouvelle commande
        order = Order.create(user: current_user, subscription: subscription)
        if order.save
          redirect_to @session.url, allow_other_host: true
        else
          # Log de l'erreur
          Rails.logger.error "Échec de la création de la commande : #{order.errors.full_messages.join(", ")}"
          redirect_to subscriptions_path, alert: "Une erreur s'est produite lors de la création de la commande."
        end
      else
        # Log de l'erreur
        Rails.logger.error "Échec de la création de la souscription : #{subscription.errors.full_messages.join(", ")}"
        redirect_to subscriptions_path, alert: "Une erreur s'est produite lors de la création de l'abonnement."
      end
      
    rescue Stripe::StripeError => e
      flash[:error] = e.message
      redirect_to subscriptions_path
    end
  end 
  
  def webhook
    payload = request.body.read
  
    # Log du payload reçu
    Rails.logger.info "Reçu webhook : #{payload}"
  
    begin
      event = Stripe::Webhook.construct_event(
        payload,
        request.env['HTTP_STRIPE_SIGNATURE'],
        Rails.application.credentials.dig(:stripe, :webhook_secret)
      )
    rescue Stripe::SignatureVerificationError => e
      # Log de l'erreur
      Rails.logger.error "Erreur lors de la vérification de la signature du webhook Stripe : #{e.message}"
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
          # Log de l'erreur
          Rails.logger.error "Échec de la création de la commande : #{order.errors.full_messages.join(", ")}"
          render json: {error: "Échec de la création de la commande : #{order.errors.full_messages.join(", ")}"}, status: :unprocessable_entity
        end
      else
        # Log de l'erreur
        Rails.logger.error "Échec de la création de la souscription : #{subscription.errors.full_messages.join(", ")}"
        render json: {error: "Échec de la création de la souscription : #{subscription.errors.full_messages.join(", ")}"}, status: :unprocessable_entity
      end
    end
  end
  
end
