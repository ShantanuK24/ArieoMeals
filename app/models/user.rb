class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable


  self.inheritance_column = :type  # STI will use 'role' column

    # Associations
    has_many :daily_meal_records, class_name: 'Employee::DailyMealRecord', dependent: :destroy

  # validates :type , presence: true

  def admin?
    type == "Admin"
  end

  def employee?
    type == "Employee"
  end
end
