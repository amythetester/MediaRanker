class UsersController < ApplicationController
  before_action :find_individual_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    if @user.nil?
      flash[:error] = "Unknown user"
      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user]

    user = User.find_by(id: username)
    if user.nil?
      flash_msg = "Welcome new user"
    else
      flash_msg = "Welcome back #{username}"
    end

    user ||= User.create(username: username)

    session[:user_id] = user.id
    flash[:success] = flash_msg
    redirect_to root_path
  end

  def create
    user = User.new(user_params)

    is_successful = user.save

    if is_successful
      flash[:success] = "User added successfully"
      redirect_to user_path(user.id)
    else
      user.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.username}"
    redirect_to root_path
  end

  private

  def find_individual_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    return params.require(:user).permit(:username, :votes)
  end
end
