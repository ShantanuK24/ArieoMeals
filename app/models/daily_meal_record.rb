class DailyMealRecord < ApplicationRecord
  belongs_to :user  #  user_id is required

  #validates :dinner, presence: false
  #t.boolean :dinner

  #validates :snack, presence: false
  #t.boolean :snack
end
