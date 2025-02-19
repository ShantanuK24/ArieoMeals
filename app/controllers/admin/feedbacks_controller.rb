class Admin::FeedbacksController < ApplicationController
    def index
      @date = params[:date].present? ? Date.parse(params[:date]) : Date.yesterday 
  
      @feedbacks = Feedback.joins(:user).where(created_at: @date.all_day)
  
      @average_dinner_rating = @feedbacks.average(:rating_for_dinner).to_f.round(2) || 0
      @average_snack_rating = @feedbacks.average(:rating_for_snack).to_f.round(2) || 0
    end
  end
  