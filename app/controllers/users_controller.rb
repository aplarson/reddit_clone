class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in! @user #need to impliment this
      redirect_to user_url(@user)
    else
      flash[:errors] = "Invalid Credentials!"
      render :new
    end
  end
  
  def show
    
  end

end