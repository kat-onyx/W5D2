class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user
      session[:session_token] = @user.session_token
      redirect_to subs_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def update
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
