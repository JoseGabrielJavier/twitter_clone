class ApplicationController < ActionController::Base
  include SessionsHelper 

  def logged_in_user
    redirect_to login_url, flash: "Please login first" unless logged_in?
  end
end
