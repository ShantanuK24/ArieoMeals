class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

     
  self.inheritance_column = :type  # STI will use 'role' column
        
  validates :type, presence: true
        
  def admin?
    type == "Admin"
  end
        
  def employee?
    type == "Employee"
  end
        
end
