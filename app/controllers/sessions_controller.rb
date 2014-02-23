class SessionsController < ApplicationController
  def new
    @user = User.new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      flash[:success] = 'You are now signed in.'
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:error] = "Your email or password is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end