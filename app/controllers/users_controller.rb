class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    
    createdUserInfo = params[:user]
    createdUserInfo['status'] = 0
    createdUserInfo['user_type'] = 'B'
    createdUserInfo['company_id'] = 0
    createdUserInfo['signup_time'] = DateTime.current
    createdUserInfo['last_signin_time'] = DateTime.current
    createdUserInfo['last_signin_ip'] = '0.0.0.0' # TODO: retrieve user client ip            
    
    @user = User.new(createdUserInfo)
    if @user.save
      puts '=========== encypted password : '+ @user.password_hash
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

end
