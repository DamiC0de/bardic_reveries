class AdminController < ApplicationController
    def dashboard
      if user_signed_in?
        if current_user.is_admin
        else
          redirect_to "/"
        end
      else
      redirect_to "/"
      end
    end
end