class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

    def new
      @feedback = Feedback.new
    end
  
    def index
      @feedbacks = Feedback.all
    end

    def show
       # @feedback = Feedback.where(user_type: "admin") 
        @feedback = Feedback.find(params[:id])
    end

    def edit
      @feedback = Feedback.find(params[:id])
    end

    def update
      if @feedback.update(feedback_params)
        redirect_to @feedback, notice: "feedback updated successfully!"
      else
        render :edit
      end
    end


    def create
      @feedback = Feedback.new(feedback_params)
      # Securely assign user_id (Use current_user if available)
      @feedback.user_id = params[:user_id] if params[:user_id].present?
    
      if @feedback.save
        redirect_to @feedback, notice: "Feedback submitted successfully!"
      else
        puts @feedback.errors.full_messages
        render :new
      end
    end
    
    def destroy
      @feedback.destroy
      redirect_to feedback_path, notice: "feedback deleted successfully."
    end

    private
    
    def feedback_params
      params.require(:feedback).permit(:user_id, :comments_for_snack, :rating_for_snack, :comments_for_dinner, :rating_for_dinner)
    end
    
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

end