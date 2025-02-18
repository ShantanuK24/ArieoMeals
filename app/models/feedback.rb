class Feedback < ApplicationRecord
  belongs_to :user

  validates :rating_for_dinner, :rating_for_snack, numericality: { only_integer: true, in: 1..5 }, allow_nil: true
  validates :comments_for_dinner, :comments_for_snack, length: { maximum: 500 }, allow_nil: true
end
