class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  private
  def require_admin
    if session[:role] != "admin"
      flash[:alert] = "You must be an admin to access this section"
      redirect_to root_path
    end
  end


  def require_mentor
    if session[:role] != "mentor"
      flash[:alert] = "You must be a mentor to access this section"
      redirect_to root_path
    end
  end

  def require_student
    if session[:role] != "student"
      flash[:alert] = "You must be a student to access this section"
      redirect_to root_path
    end
  end
end
