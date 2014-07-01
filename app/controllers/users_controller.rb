class UsersController < CommonController
  
  before_filter  :authorize, :only => [:signup_success, :profile, :edit, 
          :dashboard, :dashboard_settings, :dashboard_msg]
  
  def new
    @user = User.new
    if request.xhr?
      # respond to Ajax request
      respond_to do |format|
        format.js
      end
    else
      render  layout: false, template: "users/user.html.erb"
    end
  end

  def reg_ajax_partial_company_form
    @user = User.new
  end

  def signup_success
    #    @user = User.find( session[:user_id])
    #    render  layout: false, template: "users/user.html.erb"
    render  layout: false, template: "users/user.html.erb"
  end


def create
  
    createdUserInfo = params[:user]

    # TODO
    createdUserInfo['company_id'] = -1
    createdUserInfo['nickname'] = createdUserInfo['username']
    
    
    createdUserInfo['status'] = 0
    createdUserInfo['signup_time'] = DateTime.current
    createdUserInfo['last_signin_time'] = DateTime.current
    createdUserInfo['last_signin_ip'] = request.remote_ip # retrieve user client ip

    # create the new user
    @user = User.new(createdUserInfo)
    logger.debug '=========== before encypted password user info: '
    logger.debug @user.to_s

    if @user.save
      logger.debug '=========== after saved, encypted password user info: '
      logger.debug @user.to_s

      session[:user_id] = @user.id
      redirect_to signup_success_url #, :notice => "注册成功!"
    else
      logger.debug "Fail to create new user! redirect to reg page..."
      flash.now.alert = "Fail to create user!"
      @user = User.new
      render "new" and return
    end
  end
  
  
  
  def createOld
    createdUserInfo = params[:user]

    # handle company reg cases
    company_acc_num = params[:company][:account_num] # no [:user][:company] !
    company_legal_person = params[:company][:legal_person]
    if company_acc_num
      # reg via existing company
      logger.debug "*** reged company account num= "+ company_acc_num
      reged_comp = Company.check_existing( company_acc_num, company_legal_person)  # DO NOT miss .first , otherwise, reged_comp.id will error!
      if reged_comp
        createdUserInfo['company_id'] = reged_comp.id
      else
        logger.debug "Invalid Company account!! redirect to reg page..."
        flash.now.alert = "Invalid Company account!"
        @user = User.new
        render "new" and return
      end
    else
    # reg with new company
      new_company_params = params[:company] # no [:user][:company] !
      new_company_params["account_num"] = SecureRandom.uuid

      logger.debug "*** new company info= " + new_company_params.to_s
      new_company = Company.new(new_company_params)
      if new_company.save
        createdUserInfo['company_id'] = new_company.id
      else
        logger.debug "Fail to create company! redirect to reg page..."
        flash.now.alert = "Fail to create company!"
        @user = User.new
        render "new" and return
      end
    end

    # TODO: check username / email duplicate?

    # fill more user info
    createdUserInfo['status'] = 0
    createdUserInfo['signup_time'] = DateTime.current
    createdUserInfo['last_signin_time'] = DateTime.current
    createdUserInfo['last_signin_ip'] = request.remote_ip # retrieve user client ip

    # create the new user
    @user = User.new(createdUserInfo)
    logger.debug '=========== before encypted password user info: '
    logger.debug @user.to_s

    if @user.save
      logger.debug '=========== after saved, encypted password user info: '
      logger.debug @user.to_s

      session[:user_id] = @user.id
      redirect_to signup_success_url #, :notice => "注册成功!"
    else
      logger.debug "Fail to create new user! redirect to reg page..."
      flash.now.alert = "Fail to create user!"
      @user = User.new
      render "new" and return
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
  
  # ===================== dashboard related =============== 
  def dashboard
    @user = current_user
    render "dashboard/dashboard" and return
  end
  
  
  def dashboard_msg
    @user = current_user
    render "dashboard/dashboard_msg" and return
  end
  
  # TODO: 
  def dashboard_settings
    @user = current_user
    render "dashboard/dashboard_settings" and return
  end
end
