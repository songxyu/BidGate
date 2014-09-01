require "date"

class SessionsController < ApplicationController
   def new
      if current_user
        redirect_to root_url
      else
        if request.xhr?
          # respond to Ajax request
          respond_to do |format|
            format.js
          end
        else
          # respond to normal request        
          render  layout: false, template: "users/user.html.erb"
        end
        
      end
  
    end
    
    #TODO
    def new_logon_page
      if current_user
          redirect_to root_url
        else
        render  layout: false, template: "sessions/new_page.html.erb"
      end
    end

  def create
    user = User.authenticate(params[:email_username], params[:password])
    if user
      session[:user_id] = user.id
      logger.debug "===== user id= " + user.id.to_s + ", username= " + user.username + " successfully logon! ======"
      
      #user = User.find(user.id)
      user.last_signin_time = DateTime.current
      user.last_signin_ip = request.remote_ip
      if user.save()  # TODO: save fail! ?
        logger.debug "=== updated user login info for user=" + user.to_s
      else
        logger.debug "***** Failed to update user login info for user.id=" + user.id.to_s
      end

      if request.xhr? # redirect to dashboard after login
        #params[:redirect_url] = dashboard_url # ajax request url
        redirect_to(:controller => 'users', :action => 'dashboard', 
              :redirect_url => dashboard_url, :breadcrumb_path_key => "homepage,dashboard")
      else
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      logger.debug "Invalid email or password, redirect to logon page..."
      
      # redirect_to new_session_url  
      # render "new" and return
      redirect_to login_url
      flash.now.alert = "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
