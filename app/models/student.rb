class Student < ApplicationRecord
  validates :school_email, presence: true, uniqueness: true
  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :major, presence: true
  validates :graduation_date, presence:true
  validates :school_email, format: { with: /\A[A-Za-z0-9+.-]+@[A-Za-z0-9.-]+\z/}
  has_one_attached :profile_pic

end
