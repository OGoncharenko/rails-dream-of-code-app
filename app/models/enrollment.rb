class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :mentor_enrollment_assignments

  def is_past_application_deadline
    deadline = course.trimester.application_deadline
    return false unless deadline
    created_at > deadline
  end
end
