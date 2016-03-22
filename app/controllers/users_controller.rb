class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:user_create_error] user.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      redirect_to user_path(user)
    else
      flash[:user_update_error] = user.errors.full_messages.to_sentence
      render :edit
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(session[:user_id]).destroy
    reset_session
    redirect_to
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
