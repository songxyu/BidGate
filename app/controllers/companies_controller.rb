class CompaniesController < CommonController
  def edit
    @user = current_user
    @company = @user.company
    common_response
  end

  def verify
    @result = false;

    acc_num = params[:account_num]
    person = params[:legal_person]    
        
    if !acc_num || !person then
      render :template => "companies/verify.js.erb" and return
    end

    logger.debug "companies.verify: acc_num="+ acc_num +", legal person="+ person
    reged_comp = Company.check_existing( acc_num, person)
    if reged_comp
      @result = true
    end

    render :template => "companies/verify.js.erb" and return
  end

end