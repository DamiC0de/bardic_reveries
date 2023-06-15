class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
  
    def show
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        flash[:notice] = "Votre profil a été mis à jour avec succès."
        redirect_to profile_path(@user)
      else
        flash[:alert] = "Il y a eu une erreur lors de la mise à jour de votre profil."
        render :edit
      end
    end

    def update
        if @user.update(user_params)
          redirect_to profile_path, notice: 'Votre profil a été mis à jour avec succès.'
        else
          render :show
        end
      end
      
      private
      
    def user_params
        params.require(:user).permit(:pseudo, :email, :password, :password_confirmation)
    end
          
  
    private
  
    def set_user
      @user = current_user
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
  