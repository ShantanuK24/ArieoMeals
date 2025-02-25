class DailyMealRecord < ApplicationRecord
  belongs_to :user

  validates :snack, :dinner, inclusion: { in: [ true, false ] }
  # validates :chapati_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :on_date, ->(date) { where(date: date) }
end
