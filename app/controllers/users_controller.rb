class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: :edit

  def show # this will find the specific user based what on what id
    @user = User.find(params[:id])
  end

  def index # this will select all users from user table
    @users = User.all
  end

  def new # this will tell the webpage that we are going to create a new user
    @user = User.new
  end

  def create # after we click sign up, this function will do all the work in order to save information in the database
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Successfully Created a Account."
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit # this will tell the webpage that we are going to edit our user
    @user = User.find(params[:id])
  end

  def update # after we click save in our edit, this function will update the model based on in changes you entered
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Successfully updated profile."
      redirect_to root_url
    else
      render "edit"
    end
  end

  private # below are only functions that can be accessed only in this class

  def user_params # this will permit the all the fields from the form, for more security
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user # this will check if the peron truly owns the account he is using, to avoid editing other users edit your account
    user = User.find(params[:id])
    if user != current_user
      flash[:alert] = "You are not authorized."
      redirect_to root_url
    end
  end
end
