class UsersController < ApplicationController

	before_action :authenticate_user!
	#before_action :correct_user, only: :show
  before_action :admin_user, only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = current_user.microposts.build
  end

  def destroy
    redirect_to root_url
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user = params[:id] != nil ? User.find(params[:id]) : current_user
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = params[:id] != nil ? User.find(params[:id]) : current_user
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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
 