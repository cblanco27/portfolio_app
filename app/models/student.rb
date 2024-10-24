class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :major, presence: true
  validates :graduation_date, presence:true
  has_one_attached :profile_pic
  validate :email_format
  def email_format
      unless email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
          errors.add(:email, "must be an @msudenver.edu email address")
      end
  end


  #Creates array of accepted majors for selection
  VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS", "Computer Science BS", "Cybersecurity", "Data Science and Machine Learning Major"]

  validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}
end
