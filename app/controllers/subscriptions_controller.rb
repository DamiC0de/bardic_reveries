class SubscriptionsController < ApplicationController
    before_action :authenticate_user!
  
    def index
        @subscription_plans = SubscriptionPlan.where.not(name: 'default')
        @current_subscription = current_user.subscriptions.where('expiration_date > ?', Time.now).order(created_at: :desc).first

      end
      
    def create
      @subscription_plan = SubscriptionPlan.find(params[:subscription][:subscription_plan_id])
      @subscription = Subscription.new(user: current_user, subscription_plan: @subscription_plan, start_date: Time.now, expiration_date: Time.now + @subscription_plan.duration.days)
  
      if @subscription.save
        Order.create(user: current_user, subscription: @subscription)
        redirect_to subscriptions_path, notice: 'Subscription successfully created.'
      else
        render :index
      end
    end
end
