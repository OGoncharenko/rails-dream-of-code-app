class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :mentor_enrollment_assignments
  has_many :submissions, dependent: :destroy

  def is_past_application_deadline
    deadline = course.trimester.application_deadline
    return false unless deadline
    created_at > deadline
  end

  def student_name
    student.full_name
  end
end
