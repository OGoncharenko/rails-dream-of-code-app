require 'rails_helper'

RSpec.describe "AdminDashboard", type: :request do
  before do
    Trimester.create!(
      term: "Current term",
      year: Date.today.year.to_s,
      start_date: Date.today - 1.day,
      end_date: Date.today + 2.month,
      application_deadline: Date.today - 16.days
    )
    Trimester.create!(
      term: "Upcoming term",
      year: Date.today.year.to_s,
      start_date: Date.today + 3.month,
      end_date: Date.today + 5.month,
      application_deadline: Date.today + 2.month - 16.days
    )
    Trimester.create!(
    term: "Past term",
    year: (Date.today.year - 1).to_s,
    start_date: Date.today - 1.year,
    end_date: Date.today - 10.month,
    application_deadline: Date.today - 1.year - 16.days
    )
  end

  describe "GET /dashboard" do
    it "returns a 200 OK status" do
      get "/dashboard"

      expect(response).to have_http_status(:ok)
    end

    it "displays the current trimester information" do
      get "/dashboard"

      expect(response.body).to include("Current term - #{Date.today.year.to_s}")
    end

    it "displays the upcoming trimester information" do
      get "/dashboard"

      expect(response.body).to include("Upcoming term - #{Date.today.year.to_s}")
    end

    it "does not display past trimester information" do
      get "/dashboard"

      expect(response.body).not_to include("Past term - #{(Date.today.year - 1).to_s}")
    end
  end
end
