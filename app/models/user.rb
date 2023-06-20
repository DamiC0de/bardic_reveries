class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stories
  has_many :subscriptions
  # after_create :welcome_send
  has_many :orders

  # def welcome_send
  #   UserMailer.welcome_email(self).deliver_now
  # end

  def subscribed?
    if subscriptions.any?
      exp = subscriptions.all.sample
      subscriptions.each do |sub|
        if sub.expiration_date > exp.expiration_date
          exp = sub
        end
      end
      if exp.expiration_date > Time.now
        return true
      end
      return false
    end
    return false
  end



end
