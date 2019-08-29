class SessionsController < ApplicationController

 def home #Root View Page
 end

 def new #Login View Page
    @user = User.new
 end

 def create #User Login
  @user = User.find_by(email: params[:user][:email])
   if @user && @user.authenticate(params[:user][:password])
  session[:user_id] = @user.id
    redirect_to cars_path
   else
  flash[:notice] = "The information provided does not match. Please re-enter your login information or signup. Or maybe you are a robot???"
    redirect_to login_path
  end
 end

 def destroy #Logout
   session.clear 
   redirect_to '/'
 end

 def fbcreate #Facebook Omniauth
  @user = User.find_or_create_by(uid: auth['uid']) do |u|
   u.email = auth['info']['email']
   u.password = auth['uid']
  end
   session[:user_id] = @user.id
   redirect_to cars_path
 end

 private #Private Methods

  def auth
    request.env['omniauth.auth']
  end

end