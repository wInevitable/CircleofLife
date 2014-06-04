class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.password=(params[:user][:password])
    
    if @user.save
      sign_in!(@user)
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email)
  end
  
end
