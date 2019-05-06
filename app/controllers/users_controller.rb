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

  def new
    @user = User.new
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

  private

  def find_individual_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    return params.require(:user).permit(:username, :votes)
  end
end
