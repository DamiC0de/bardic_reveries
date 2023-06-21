class AddSubscriptionPlanToSubscriptions < ActiveRecord::Migration[6.0]
  def up
    default_plan = SubscriptionPlan.new(name: 'default', cost: 0.0, duration: 1)
    default_plan.save(validate: false)
    change_table :subscriptions do |t|
      t.references :subscription_plan, foreign_key: true
    end
    Subscription.update_all(subscription_plan_id: default_plan.id)
    change_column_null :subscriptions, :subscription_plan_id, false
  end

  def down
    remove_reference :subscriptions, :subscription_plan, foreign_key: true
  end
end


