module ResponseUtil
  
  def common_response    
    logger.debug "ResponseUtil.common_response called..."
    
    render :template => "layouts/content_area.js.erb" and return
      # respond_to do |format|
        # format.js  { render :file => "../content_area.js.erb" }  # , :xml, :json
      # end
  end
  
end