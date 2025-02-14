class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  has_many :daily_meal_records, dependent: :destroy 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable


  self.inheritance_column = :type  # STI will use 'role' column

  # validates :type , presence: true

  def admin?
    type == "Admin"
  end

  def employee?
    type == "Employee"
  end
end
