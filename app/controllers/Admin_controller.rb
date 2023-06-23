class AdminController < ApplicationController
  def dashboard
    if user_signed_in? && current_user.is_admin 
    else
      redirect_to "/"
    end
  end
end