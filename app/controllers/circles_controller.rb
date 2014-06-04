class CirclesController < ApplicationController
  def new
    @circle = Circle.new
    @user = current_user
  end
  
  def create
    @user = User.find(params[:user_id])
    @circle = @user.circles.new(circle_params)
    
    # @user.circles.new(params.require(:circle).permit(:name)) 
    # memberships.new(params.require(:circle).permit(member_id: []))
    
    if @circle.save
      redirect_to @circle
    else  
      flash.now[:alert] = @circle.errors.full_messages
      render :new
    end
  end
  
  def edit
    @circle = Circle.find(params[:id])
    @user = current_user    
  end
  
  def update
    @circle = Circle.find(params[:id])
      
    if @circle.update(circle_params)
      redirect_to @circle
    else
      flash.now[:alert] = @circle.errors.full_messages
      render :edit
    end
  end
  
  def show
    @circle = Circle.find(params[:id])
  end
  
  def destroy
    @circle = Circle.find(params[:id])
    @circle.delete
    
    redirect_to @circle.user
  end
  
  private
  
  def circle_params
    params.require(:circle).permit(:name, member_ids: [])
  end
end
