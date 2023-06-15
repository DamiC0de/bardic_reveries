class Subscription < ApplicationRecord
    belongs_to :user
    has_one :order
  
    def active?
      expiration_date > Time.now
    end
  
  end