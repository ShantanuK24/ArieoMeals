class Feedback < ApplicationRecord
  belongs_to :user

  validates :rating_for_snack, :rating_for_dinner, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  validates :comments_for_dinner, length: { maximum: 500 }, allow_nil: true
end
