class Feedback < ApplicationRecord
  belongs_to :user
    validates :rating_for_dinner, presence: true, inclusion: { in: 1..5 }  # Ensure rating for dinner is between 1 and 5 
    validates :rating_for_snack, presence: true, inclusion: { in: 1..5 }  # Ensure rating for snack is between 1 and 5 
end
