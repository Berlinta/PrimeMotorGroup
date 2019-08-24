class SessionsController < ApplicationController

  def home
  end

  def new
    @user = User.new
  end

  def create #login
   @user = User.find_by(email: params[:user][:email])
   if @user && @user.authenticate(params[:user][:password])
   session[:user_id] = @user.id
     redirect_to cars_path
   else
    redirect_to login_path
   end
  end

  def destroy
    session.clear
    redirect_to '/'
  end

#   def fbcreate
#   @user = User.find_or_create_by(uid: auth['uid']) do |u|
#     u.email = auth['info']['email']
#     u.password = auth['uid']
#   end
#     session[:user_id] = @user.id
#     redirect_to cars_path
# end

#  private

#   def auth
#     request.env['omniauth.auth']
#   end

end