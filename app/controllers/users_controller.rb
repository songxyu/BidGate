class UsersController < CommonController
  include UsersHelper
  
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
      @company = Company.new
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
    #common_response
    
    respond_to do |format|
      format.js { render :file => "dashboard/dashboard_profile.js.erb" }  # , :xml, :json
    end
  end
  
  def update
    changedUserInfo = params[:user]
    @user = User.find(params['id']) # user id
    if @user
       @user.nickname = changedUserInfo['nickname']      
       @user.contact = changedUserInfo['contact']
       @user.contact_title = changedUserInfo['contact_title'].to_i
       @user.contact_cellphone = changedUserInfo['contact_cellphone']
       @user.contact_tel = changedUserInfo['contact_tel']
       
       email = changedUserInfo['email']
       if !UsersHelper.checkUserEmailUnique(email, @user.id)
          logger.warn "Fail to update user! due to email duplicate!"
          flash.now.alert = "保存失败: 邮箱已被其他用户使用!"          
       else
          @user.email = email
          if @user.save(:validate => false) #update_attributes(changedUserInfo)
             logger.debug "save user info ok!"
             flash.now.notice = "保存成功!"
          else
            logger.error "Fail to update user!"
            flash.now.alert = "无法更新用户信息!"
          end
       end
      
    else
      logger.error "cannot find user! Fail to update user!"
      flash.now.alert = "无法更新用户信息!"      
    end
     
     respond_to do |format|
        format.js { render :file => "dashboard/dashboard_profile.js.erb" }  # , :xml, :json
     end
  end
  
  # ===================== dashboard related =============== 
  def dashboard
    @user = current_user
    render "dashboard/dashboard" and return
  end
  
  # new add - song
  def dashboard_profile
    @user = current_user
    render "dashboard/dashboard_profile" and return
  end
  
  def change_password
     # ref to src of has_secure_password
     @user = current_user
     old_pw = params[:old_password]
     if @user.authenticate(old_pw)
       @user.password = params[:password]
       @user.password_confirmation = params[:password_confirmation]
       if @user.save
         logger.debug "change password successfully!"
         flash.now.notice = "密码已修改成功!"
       else
         logger.debug "change password failed, may inconsistent inputs."
         flash.now.alert = "密码修改失败! 确认密码输入一致"
       end      
     else
      logger.debug "old password is incorrect"
      flash.now.alert = "原密码错误!"
     end
     
     #render "dashboard/dashboard_profile" and return
     # must use ajax...
     respond_to do |format|
      format.js { render :file => "dashboard/dashboard_profile.js.erb" }  # , :xml, :json
     end
  end
  
  
  def edit_profile
    
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
