class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan
  has_many :orders

  validates :user_id, :subscription_plan_id, presence: true

  def active?
    expiration_date > Time.now
  end
end
