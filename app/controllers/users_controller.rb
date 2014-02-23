class UsersController < CommonController
  def new
    @user = User.new
  end

  def create
    createdUserInfo = params[:user]

    # handle company reg cases
    company_acc_num = params[:company][:account_num] # no [:user][:company] !
    company_legal_person = params[:company][:legal_person]
    if company_acc_num
      logger.debug "*** reged company account num= "+ company_acc_num
      reged_comp = Company.where(account_num: company_acc_num).first # DO NOT miss .first , otherwise, reged_comp.id will error!
      if reged_comp && reged_comp.legal_person == company_legal_person then
        createdUserInfo['company_id'] = reged_comp.id
      else
        flash.now.alert = "Invalid Company account!"
        render "new"
      end
    else
      new_company_params = params[:company] # no [:user][:company] !
      new_company_params["account_num"] = SecureRandom.uuid

      logger.debug "*** new company info= " + new_company_params.to_s
      new_company = Company.new(new_company_params)
      if new_company.save
        createdUserInfo['company_id'] = new_company.id
      else
        flash.now.alert = "Fail to create company!"
        render "new"
      end
    end

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
      redirect_to root_url, :notice => "注册成功!"
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
