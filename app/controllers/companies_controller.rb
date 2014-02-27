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

end