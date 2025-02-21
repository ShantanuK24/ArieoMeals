class Admin::DailyMealRecordsController < ApplicationController
    before_action :authorize_admin
    def index
        @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
        @meal_type = params[:meal_type]

      @meal_records = DailyMealRecord.where(date: @date)

      if @meal_type == "snacks"
        @meal_records = @meal_records.where(snack: true)
      elsif @meal_type == "dinner"
        @meal_records = @meal_records.where(dinner: true)
      end
    end

    private
    def authorize_admin
      redirect_to root_path, alert: "Access Denied" unless current_user.admin?
    end
end
