class Lesson < ApplicationRecord
  belongs_to :course

  has_many :topic_lessons, dependent: :destroy
  has_many :topics, through: :topic_lessons
  has_many :submissions, dependent: :destroy
end
