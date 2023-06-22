class OrderController < ApplicationController
  def new
  end

  def create
    @stripe_amount = 500 # Assurez-vous de définir la bonne valeur ici

    begin  
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })  
      
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount,  # Utiliser @stripe_amount défini précédemment
        description: "Achat d'un abonnement à nos histoires",
        currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_path and return
    end

    # Après le rescue, si le paiement a réussi
    # Vous pouvez ajouter ici votre logique pour gérer la réussite du paiement.
    # Par exemple, vous pourriez rediriger l'utilisateur vers une page de réussite.
  end
end
