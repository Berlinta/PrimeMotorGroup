class UsersController < ApplicationController

 def new
  @user = User.new
 end

 def create #Log the user in
    @user = User.new(user_params)
   if @user.save 
    session[:user_id] = @user.id
    redirect_to cars_path
   else
    flash[:alert] = "Email has been taken, please try another one"
    render :new
  end
 end

 private #Private Methods

 def user_params
  params.require(:user).permit(:email, :password)
 end

end