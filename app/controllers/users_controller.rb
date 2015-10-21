class UsersController < ApplicationController

	before_action :authenticate_user!
	#before_action :correct_user, only: :show
  before_action :admin_user, only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
    redirect_to root_url
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def incorrect_user_path_for
    root_url
  end

  # Confirms the correct user
  def correct_user
    if !is_correct_user
      redirect_to incorrect_user_path_for
    end
  end

  def is_correct_user
  	@user = User.find(params[:id])
    @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin? 
  end
  
end
 