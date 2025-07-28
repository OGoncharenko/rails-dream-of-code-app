class Topic < ApplicationRecord
  TITLES = %w[
    SQL
    Data Modeling
    Javascript
    CSS
    Automated Testing
    Debugging
    Web Request Cycle
    HTTP
  ]

  has_many :topic_lessons, dependent: :destroy
  has_many :lessons, through: :topic_lessons

  validates :title, inclusion: { in: TITLES }
end
