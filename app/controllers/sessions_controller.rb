class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Successfully logged in."
      redirect_to root_path
    else
      flash[:danger] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = "Successfully logout."
    redirect_to root_url
  end
end
