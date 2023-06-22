class SetStripePriceIdForWeeklyPlan < ActiveRecord::Migration[7.0]
  def up
    plan = SubscriptionPlan.find_by(name: "weekly")
    if plan
      plan.update(stripe_price_id: "price_1NLjdpBNllMt473iKj6BHNvs")
    else
    end
  end

  def down
  end
end
