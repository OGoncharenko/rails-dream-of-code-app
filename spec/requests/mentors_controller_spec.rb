require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context "mentors exist" do
      before do
        (1..2).each do |i|
          Mentor.create!(
            first_name: "MentorFirst#{i}",
            last_name: "MentorLast#{i}",
            email: "#{i}@example.com",
            max_concurrent_students: 3
            )
        end
      end

      it "returns a list of mentors" do
        get '/mentors'

          expect(response.body).to include('MentorFirst1')
          expect(response.body).to include('MentorLast1')
          expect(response.body).to include('MentorFirst2')
          expect(response.body).to include('MentorLast2')
        end
    end
  end

  describe "GET /mentors/:id" do
    context "mentor exists" do
      let!(:mentor) {
        Mentor.create!(
          first_name: "MentorFirst",
          last_name: "MentorLast",
          email: "mentor@example.com",
          max_concurrent_students: 3,
          )
      }
      it "returns the mentor details" do
        get "/mentors/#{mentor.id}"

          expect(response.body).to include('MentorFirst')
          expect(response.body).to include('MentorLast')

          expect(response.body).to include('Edit this mentor')
          expect(response.body).to include('Back to mentors')
          expect(response.body).to include('Destroy this mentor')
      end
    end

    context "mentor does not exist" do
      it "returns a 404 not found" do
        get "/mentors/99999"

          expect(response).to have_http_status(404)
      end
    end
  end
end