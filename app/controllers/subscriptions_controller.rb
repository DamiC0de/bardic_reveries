class SubscriptionsController < ApplicationController
    def index
    end
    def add
        if user_signed_in?
            if current_user.subscribed?
                exp =(current_user.subscriptions).all.sample
                current_user.subscriptions.each do |sub|
                    if sub.active?
                        if sub.expiration_date >= exp.expiration_date
                            exp = sub
                        end
                    end
                end
                new_exp = exp.expiration_date + 1.month
                exp.update(expiration_date:new_exp)
                
            else
                Subscription.create(user:current_user,start_date:Time.now,expiration_date:(Time.now + 1.day))
            end
        end  
        redirect_to "/subscriptions/index"
    end
end
