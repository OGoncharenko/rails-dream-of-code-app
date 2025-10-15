class Student < ApplicationRecord
  has_many :enrollments
  has_many :submissions, through: :enrollments
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }

  def full_name
    "#{first_name} #{last_name}"
  end
end
