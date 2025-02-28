class Employee::DailyMealRecordsController < ApplicationController
  before_action :authenticate_user!
    before_action :check_access_time, only: [:create] # Restrict access based on time
    # GET /daily_meal_records/new
    def new
      @daily_meal_record = DailyMealRecord.new
    end

    # POST /daily_meal_records
    def create
      unless check_duplicate_record
        @daily_meal_record = current_user.daily_meal_records.new(meal_params)
        @daily_meal_record.date = Date.today
        @daily_meal_record.user_id = current_user.id # Assign user_id
        if @daily_meal_record.save
          redirect_to new_employee_daily_meal_record_path, notice: "Meal added successfully!"
        else
          flash.now[:alert] = "Failed to add meal. Please try again."
          render :new
        end
      else
        redirect_to new_employee_daily_meal_record_path, notice: "Meal already added successfully!"
      end
    end

    private
    # Strong parameters
    def meal_params
      params.require(:daily_meal_record).permit(:date, :snack, :dinner, :chapati_count)
    end

    def check_duplicate_record
     current_user.daily_meal_records.find_by(date: Date.today).present?
    end

    def check_access_time
      current_time = Time.now.utc.in_time_zone("Asia/Kolkata")
      formatted_time = current_time.strftime("%I:%M %p") # Display time in 12-hour format with AM/PM
      current_hour = current_time.hour
      current_min = current_time.min

      unless current_hour == 12 || (current_hour == 13 && current_min == 0) # Allows from 12:00 to 12:59 PM IST
         redirect_to new_employee_daily_meal_record_path, alert: "You can only access meals between 12:00 PM and 1:00 PM IST. Current time: #{formatted_time}."
      end
    end
    
end
