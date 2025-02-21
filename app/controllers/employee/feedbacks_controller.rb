class Employee::FeedbacksController < ApplicationController
  before_action :set_daily_meal_record, only: [:new, :create]

  def new
    # feedback for yesterday's meal
    if @daily_meal_record
     @feedback =  Employee::Feedback.new
    else
      redirect_to new_employee_feedback_path, notice: "You are not eligible to provide feedback for yesterday's meal 
      because you did not select a meal.!"
    end
  end
  
  def create
    @feedback = Employee::Feedback.where(created_at: Date.today.all_day, user_id: current_user.id)
    unless @feedback.present?
      @feedback = Employee::Feedback.new(feedback_params)
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
    @daily_meal_record = Employee::DailyMealRecord.find_by(user_id: current_user.id, date: Date.yesterday)
    
    return false unless @daily_meal_record.present?
  end

  def feedback_params
    params.require(:employee_feedback).permit( :rating_for_snack, :rating_for_dinner, :comments_for_dinner)
  end

end
