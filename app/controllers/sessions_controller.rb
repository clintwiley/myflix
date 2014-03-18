class SessionsController < ApplicationController
  def new
    @user = User.new
    redirect_to home_path if current_user
  end

  def create
    @user = User.where(email: params[:user][:email]).first
    if @user && @user.authenticate(params[:user][:password])
      flash[:success] = 'You are now signed in.'
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:danger] = "Your email or password is incorrect."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end