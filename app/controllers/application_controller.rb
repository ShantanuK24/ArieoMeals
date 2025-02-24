class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_daily_meal_records_path # Redirect to /admin/daily_meal_records
    elsif resource.employee?
      new_employee_daily_meal_record_path
    else
      root_path
    end
  end
end
