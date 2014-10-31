class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(*user_params.values)
    if @user
      log_in! @user 
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "I'm sorry but it appears you don't exist"
      @user = User.new(username: user_params[:username])
      render :new
    end
  end
  
  def destroy
    log_out!
    redirect_to new_session_url
  end
end