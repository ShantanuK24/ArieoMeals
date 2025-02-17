class Employee::FeedbacksController < ApplicationController

    def new
      @feedback = Feedback.new
    end
  
    def create
      @feedback = current_user.feedbacks.build(feedback_params)
      @feedback.date = Date.yesterday  # it's for yesterday's meal

          if @feedback.save
              redirect_to feedbacks_path, notice: "Thank you for your feedback!"
          else
              render :new
          end
    end

    def index
      @feedbacks = current_user.feedbacks.where(date: Date.yesterday)
    end
    
    private
    
    def feedback_params
      params.require(:feedback).permit(:user_id, :comments_for_snack, :rating_for_snack, :comments_for_dinner, :rating_for_dinner)
    end

end