class SubsController < ApplicationController
  before_action :check_sub_ownership, only: [:edit, :update]
  
  def index
    @subs = Sub.all
  end
  
  def show
    @sub = Sub.find(params[:id])
  end
  
  def new
    @sub = Sub.new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end
  
  def destroy
    Sub.destroy!(params[:id])
    redirect_to user_url(current_user)
  end
  
  private
    def sub_params
      params.require(:sub).permit([:title, :description])
    end
    
    def check_sub_ownership
      Sub.find(params[:id]).moderator_id == current_user.id
    end
end