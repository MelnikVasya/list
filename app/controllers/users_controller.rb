class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user,   only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user, only: [:welcome, :new, :create]
  def welcome
      redirect_to current_user if signed_in?
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:info] = 'Welcome to the Todo lists!'
      redirect_to @user
    else
      render 'new'
    end
  end
  def show
    @user = User.find(params[:id])
    @task_lists = @user.task_lists
  end
  def edit
  end
  def update
    if @user.update_attributes(user_params)
      flash[:info] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path

  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url
      end
    end
    def correct_user
      @user = User.find(params[:id]) rescue nil
      redirect_to(root_url) unless current_user?(@user)
    end
end
