class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #  :confirmable

  # Single Table Inheritance
  self.inheritance_column = :type

  # Ensure role is set
  after_initialize :set_default_type, if: :new_record?
  # before_create :auto_confirm_admin

  # private

  def admin?
    type == "Admin"
  end

  def employee?
    type == "Employee"
  end
  private

  # def auto_confirm_admin
  #   if type == "Admin"
  #     self.skip_confirmation! if type == "Admin"
  #   end
  # end


  private

  def set_default_type
    self.type ||= "Employee"
  end
end
