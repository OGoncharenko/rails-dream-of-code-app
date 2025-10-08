class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :enrollment
  has_one :student, through: :enrollment
  has_one :course, through: :enrollment
end
