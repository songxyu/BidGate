class CompaniesController < CommonController
  def edit
    @user = current_user    
    @company = @user.company
    common_response
  end
  

end