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
      flash[:errors] = "I'm sorry but it appears you don't exist"
      render :new
    end
  end
  
  def destroy
    log_out! current_user
    redirect_to new_session_url
  end
end