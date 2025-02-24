class Employee::FeedbacksController < ApplicationController
  before_action :set_daily_meal_record, only: [ :new, :create ]

  def new
      # feedback for yesterday's meal
      if @daily_meal_record
          if Date.today.monday?
            # If today is Monday, check for Friday’s record explicitly
            target_date = Date.today - 3  # Friday
          else
            # Otherwise, check for yesterday’s record
            target_date = Date.yesterday
          end
        
      @daily_meal_record = DailyMealRecord.find_by(user_id: current_user.id, date: target_date)
      @feedback =  Feedback.new
      else
        redirect_to new_employee_daily_meal_record_path, notice: "You are not eligible to provide feedback for yesterday's meal 
        because you did not select a meal.!"
      end
  end

  def create
    @feedback = Feedback.where(created_at: Date.today.all_day, user_id: current_user.id)
    unless @feedback.present?
      @feedback = Feedback.new(feedback_params)
      @feedback.user = current_user  # the feedback is for yesterday's meal

      if @feedback.save
        redirect_to new_employee_feedback_path, notice: "Thank you for your feedback!"
      else
        render :new
      end
    else
      redirect_to new_employee_feedback_path, notice: "Feedback already submitted"
    end
  end

  private

  def set_daily_meal_record
    @daily_meal_record = DailyMealRecord.find_by(user_id: current_user.id, date: Date.yesterday)
    
    return false unless @daily_meal_record.present?
  end

  def feedback_params
    params.require(:employee_feedback).permit(:rating_for_snack, :rating_for_dinner, :comments_for_dinner)
  end
end
