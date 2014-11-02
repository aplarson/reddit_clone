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
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :show
    else
      redirect_to user_url(@user)
    end
  end

end