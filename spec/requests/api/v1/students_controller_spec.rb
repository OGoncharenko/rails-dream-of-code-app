require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "POST /api/v1/students" do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    it "creates a new student" do
      expect {
        post '/api/v1/students', params: valid_attributes
      }.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq("validstudent@example.com")
    end

    it "returns errors for invalid attributes" do
      invalid_attributes = {
        student: {
          first_name: '',
          last_name: '',
          email: 'invalidemail'
        }
      }

      post '/api/v1/students', params: invalid_attributes

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("First name can't be blank")
      expect(JSON.parse(response.body)['errors']).to include("Last name can't be blank")
      expect(JSON.parse(response.body)['errors']).to include("Email is invalid")
    end
  end
end
