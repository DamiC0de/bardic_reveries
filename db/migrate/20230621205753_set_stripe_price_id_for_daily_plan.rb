class SetStripePriceIdForDailyPlan < ActiveRecord::Migration[7.0]
  def up
    plan = SubscriptionPlan.find_by(name: "daily")
    if plan
      plan.update(stripe_price_id: "price_1NLTYsBNllMt473iAz7Nc5q5")
    else
    end
  end

  def down
  end
end
