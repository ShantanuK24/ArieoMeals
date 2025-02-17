module Employee
    class DailyMealRecord < ApplicationRecord
     
      #belongs_to :user
      belongs_to :user, optional: true

    end
  end