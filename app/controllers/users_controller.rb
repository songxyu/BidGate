class UsersController < CommonController
  def new
    @user = User.new
    common_response
  end

  def create
    
    createdUserInfo = params[:user]
    createdUserInfo['status'] = 0
    createdUserInfo['company_id'] = 1
    createdUserInfo['signup_time'] = DateTime.current
    createdUserInfo['last_signin_time'] = DateTime.current
    createdUserInfo['last_signin_ip'] = '0.0.0.0' # TODO: retrieve user client ip            
    
    @user = User.new(createdUserInfo)
     puts '=========== before encypted password user info: '
      p( @user )
      
    if @user.save
      puts '=========== after saved, encypted password user info: '
      p( @user )
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def profile
    @user = current_user
    params[:action] = "show"
    common_response
  end
  
  
  def edit
    @user = current_user
    common_response
  end
end
