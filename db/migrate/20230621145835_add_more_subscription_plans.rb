class AddMoreSubscriptionPlans < ActiveRecord::Migration[7.0]
  def up
    SubscriptionPlan.create(name: 'daily', cost: 2.0, duration: 1)
    SubscriptionPlan.create(name: 'weekly', cost: 10.0, duration: 7)
    SubscriptionPlan.create(name: 'monthly', cost: 30.0, duration: 30)
  end

  def down
    SubscriptionPlan.where(name: ['daily', 'weekly', 'monthly']).destroy_all
  end
end