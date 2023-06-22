class SubscriptionPlan < ApplicationRecord
    has_many :subscriptions
  
    PLANS = {
     daily:   { cost: 2.0, duration: 1.day },
      weekly:  { cost: 10.0, duration: 7.days },
      monthly: { cost: 30.0, duration: 30.days }
    }.freeze
  
    validates :name, :cost, :duration, presence: true
    validates :name, inclusion: { in: PLANS.keys.map(&:to_s) }
  
    def self.initialize_plans
      PLANS.each do |name, options|
        plan = find_or_initialize_by(name: name.to_s)
        plan.update!(options)
      end
    end
  end

  
#   Voici ce que fait ce code :

#has_many :subscriptions établit une relation "one-to-many" avec le modèle Subscription, qui signifie qu'un SubscriptionPlan peut avoir plusieurs Subscriptions.

#PLANS est une constante qui définit les différents plans d'abonnement que vous voulez offrir. Pour l'instant, nous avons trois plans : daily, weekly et monthly, avec leurs coûts respectifs et durées.

#Les deux lignes suivantes sont des validations qui garantissent que chaque SubscriptionPlan a un name, cost et duration.

#validates :name, inclusion: { in: PLANS.keys.map(&:to_s) } garantit que le name d'un SubscriptionPlan doit être l'un des clés définies dans PLANS.

#initialize_plans est une méthode de classe qui crée ou met à jour les plans d'abonnement dans la base de données pour correspondre à ce qui est défini dans PLANS. Cette méthode pourrait être appelée dans un fichier de seeds ou lors de l'initialisation de l'application pour s'assurer que les plans d'abonnement corrects sont toujours disponibles.