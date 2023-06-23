class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Votre profil a été mis à jour avec succès.'
    else
      render :show
    end
  end
  
  private
    
  def set_user
    @user = current_user
  end
  
  def user_params
    params.require(:user).permit(:pseudo, :email, :password, :password_confirmation)
  end

end
  