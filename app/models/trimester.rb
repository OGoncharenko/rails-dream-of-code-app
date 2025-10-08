class Trimester < ApplicationRecord
  TERMS = %w[Spring Summer Fall Winter].freeze

  has_many :courses, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true

  def term_and_year
    "#{term.capitalize} #{start_date.year}"
  end
end
