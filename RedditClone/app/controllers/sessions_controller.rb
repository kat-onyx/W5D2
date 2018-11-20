class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.validate_credentials(params[:user][:email], params[:user][:password])

    if user
      session[:session_token] = user.reset_session_token!
      redirect_to subs_url
    else
      flash[:errors] = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
