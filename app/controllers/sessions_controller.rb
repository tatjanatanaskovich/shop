class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You are successfully logged in!"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information. Try again!"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You are logged out!"
    redirect_to root_path
  end
  
end