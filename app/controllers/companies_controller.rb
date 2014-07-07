class CompaniesController < CommonController
  def edit
    @user = current_user
    @company =  Company.find(@user.company.id)
    #common_response
    
    # for dashboard
    respond_to do |format|
      format.js { render :file => "dashboard/dashboard_profile.js.erb" }  # , :xml, :json
    end
  end

  def verify
    @result = false;

    acc_num = params[:account_num]
    person = params[:legal_person]

    # new company
    comp_name = params[:name]
    comp_license = params[:license_image]
    comp_addr = params[:register_address]

    if !acc_num then
      if comp_name && comp_license && person && comp_addr then
        # TODO: check the license, new company
        @result = true
      end
    else
      if person then
        logger.debug "companies.verify: acc_num="+ acc_num +", legal person="+ person
        reged_comp = Company.check_existing( acc_num, person)
        if reged_comp
          @result = true
        end
      end
    end

    render :template => "companies/verify.js.erb" and return
  end


  def update
    changedCompnayInfo = params[:company]
    @company = Company.find(params['id'])
    if @company
      @company.legal_person = changedCompnayInfo['legal_person']
      @company.main_biz = changedCompnayInfo['main_biz']
      @company.register_address = changedCompnayInfo['register_address']
      @company.register_capital = changedCompnayInfo['register_capital']
      
      if @company.save
         logger.debug "save company info ok!"
         flash.now[:notice] = "保存成功!"
      else
        logger.error "Fail to update company!"
        flash.now.alert = "无法更新公司信息!"
      end
      
    else
      logger.error "cannot find company! Fail to update company!"
      flash.now.alert = "无法更新公司信息!"      
    end
     
     respond_to do |format|
        format.js { render :file => "dashboard/dashboard_profile.js.erb" }  # , :xml, :json
      end
  end
  
  
end