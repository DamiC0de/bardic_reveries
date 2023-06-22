class SetStripePriceIdForMonthlyPlan < ActiveRecord::Migration[7.0]
  def up
    plan = SubscriptionPlan.find_by(name: "monthly")
    if plan
      plan.update(stripe_price_id: "price_1NLjsYBNllMt473iptqwpLD5")
    else
    end
  end

  def down
  end
end