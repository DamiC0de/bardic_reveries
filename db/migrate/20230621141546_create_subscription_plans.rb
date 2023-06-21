class CreateSubscriptionPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.float :cost
      t.integer :duration

      t.timestamps
    end
  end
end
