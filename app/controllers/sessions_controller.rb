class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Successful login"
      redirect_to user
    else
      flash.now[:danger] = user ? "Incorrect password" : "User doesn't exist"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
