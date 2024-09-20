class Student < ApplicationRecord
  email_regex = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/
  validates :school_email, presence: true, uniqueness: true
  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :major, presence: true
  validates :minor, presence: true
  validates :graduation_date, presence:true
  validates :school_email, format: { with: /\A[A-Za-z0-9+.-]+@[A-Za-z0-9.-]+\z/}

end
