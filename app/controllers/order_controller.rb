class OrderController < ApplicationController
  def new
  end

  def create
    # Before the rescue, at the beginning of the method
@stripe_amount = 500begin  customer = Stripe::Customer.create({
  email: params[:stripeEmail],
  source: params[:stripeToken],
  })  charge = Stripe::Charge.create({
  customer: customer.id,
  amount: 100,
  description: "Achat d'un abonnement à nos histoires",
  currency: 'eur',
  })rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_order_path
  end# After the rescue, if the payment succeeded
  end
end
