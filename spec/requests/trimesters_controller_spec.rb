require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context "trimester exists" do
      let!(:trimesters) do
        %w[Spring Summer].map do |term|
          Trimester.create!(
            term: term,
            year: "2025",
            start_date: "2025-01-01",
            end_date: "2025-03-31",
            application_deadline: "2024-12-15"
          )
        end
      end

    it "returns a list of trimesters" do
      get '/trimesters'

        expect(response.body).to include('Spring 2025')
        expect(response.body).to include('Summer 2025')
      end
    end

    context "trimester do not exist" do
      it "page has a title and no list items" do
        get '/trimesters'

        expect(response.body).to include('Trimesters')
        expect(response.body).not_to include('<li>')
      end
    end
  end
  describe "PUT /trimesters/:id" do
    context "when the trimester exists" do
      let(:trimester) do
        Trimester.create!(
          term: "Spring",
          year: "2025",
          start_date: "2025-01-01",
          end_date: "2025-01-01",
          application_deadline: "2025-01-01"
        )
      end

      it "updates the trimester and redirects" do
        put "/trimesters/#{trimester.id}", params: {
          trimester: { application_deadline: "2025-02-01" }
        }

        expect(response).to redirect_to(trimester_path(trimester))
        follow_redirect!

        expect(response.body).to include('Trimester was successfully updated.')
        expect(trimester.reload.application_deadline).to eq(Date.parse("2025-02-01"))
      end

      it "returns 400 when application_deadline is missing" do
        put "/trimesters/#{trimester.id}", params: { trimester: { } }

        expect(response).to have_http_status(:bad_request)
      end

      it "returns 400 when application_deadline is invalid" do
        put "/trimesters/#{trimester.id}", params: {
          trimester: { application_deadline: "not-a-date" }
        }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when the trimester does not exist" do
      it "returns 404" do
        put "/trimesters/999999", params: {
          trimester: { application_deadline: "2025-02-01" }
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

