class AddDescriptionToSubscriptionPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_plans, :description, :string
  end
end
