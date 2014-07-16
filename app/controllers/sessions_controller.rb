class SessionsController < ApplicationController
  def new
    @nav_sign_in  = true
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      redirect_to signin_path
      flash[:warning] = 'Invalid email/password combination'
    end

  end
  def destroy
    sign_out
    redirect_to root_path
  end
end
