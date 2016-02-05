class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])

    if user.nil?
      flash[:error] = "Sorry, email not found"
      render :new
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:error] = nil
      redirect_back_or user_path(user)
    else
      flash[:error] = "That's not the correct password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end