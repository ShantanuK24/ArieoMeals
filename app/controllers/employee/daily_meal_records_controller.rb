class Employee::DailyMealRecordsController < ApplicationController
  before_action :check_access_time, only: [:new] # Restrict access based on time

    # GET /daily_meal_records/new
    def new
         @daily_meal_record = DailyMealRecord.new
    end
  
    # POST /daily_meal_records
    def create
      @daily_meal_record = current_user.daily_meal_records.new(meal_params) 
      @daily_meal_record.user_id = params[:user_id] # Assign user_id 
  
      if @daily_meal_record.save
        redirect_to @daily_meal_record, notice: "Meal added successfully!"
      else
       # puts @daily_meal_record.errors.full_messages
        #flash[:alert] = @daily_meal_record.errors.full_messages.join(", ")
        render :new
      end
    end
  
    private
    # Strong parameters
    def meal_params
      params.require(:daily_meal_record).permit(:date, :snack, :dinner, :chapati_count)
    end
  
    def check_access_time
    current_hour = Time.zone.now.hour
    unless current_hour == 12  # Only allow access between 12:00 PM and 12:59 PM
      redirect_to @daily_meal_record, alert: "You can only access meals between 12:00 PM and 1:00 PM."
    end

  end
end

