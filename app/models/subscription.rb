class Subscription < ApplicationRecord
    belongs_to :user
    has_many :orders
  
    def active?
      expiration_date > Time.now
    end
  
  end