class SessionsController < ApplicationController
  
  def new
    if signed_in?
      redirect_to current_user
    else
      render :new
    end
  end
  
  def create
    @user = User.find_by_credentials(
      session_params[:email], session_params[:password]
    )
    
    if @user
      sign_in! @user
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end
  
  def destroy
    sign_out! 
    
    redirect_to new_session_url
  end
  
  private
  
  def session_params
    params.require(:user).permit(:email, :password)
  end
end