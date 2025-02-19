class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
    before_action :authenticate_user!


    def after_resetting_password_path_for(resource)
      new_user_session_path
    end

    def after_sign_in_path_for(resource)
      if resource.is_a?(Admin)
        admin_dashboard_path
      elsif resource.employee?
        employee_dashboard_path
      else
        root_path
      end
    end
end
