class Student < ApplicationRecord
  validates :school_email, presence: true, uniqueness: true
  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :major, presence: true
  validates :graduation_date, presence:true
  validates :school_email, format: { with: /\A[A-Za-z0-9+.-]+@[A-Za-z0-9.-]+\z/}
  has_one_attached :profile_pic

  #Creates array of accepted majors for selection
  VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS", "Computer Science BS", "Cybersecurity", "Data Science and Machine Learning Major"]

  validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}
end
