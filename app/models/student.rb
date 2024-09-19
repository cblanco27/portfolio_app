class Student < ApplicationRecord

  validates :school_email, presence: true, uniqueness: true
  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :major, presence: true
  validates :minor, presence: true
  validates :graduation_date, presence:true

end
