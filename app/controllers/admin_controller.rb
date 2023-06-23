class AdminController < ApplicationController
    before_action :authenticate_admin!

    def show
    end

    private

    def authenticate_admin!
      redirect_to root_path unless current_user&.is_admin
    end
end