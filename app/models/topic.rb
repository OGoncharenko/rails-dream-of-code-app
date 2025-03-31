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
  validates :title, inclusion: { in: TITLES }
end
