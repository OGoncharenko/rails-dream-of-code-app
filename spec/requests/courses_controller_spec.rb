require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /courses" do
    context "courses exist" do
      before do
        (1..2).each do |i|
          coding_class = CodingClass.create!(
            title: "Coding Class #{i}",
            description: "Class Description #{i}"
          )
          trimester = Trimester.create!(
            term: "Term #{i}",
            year: "2025",
            start_date: "2025-01-01",
            end_date: "2025-01-01",
            application_deadline: "2025-01-01"
          )

          Course.create!(
            coding_class: coding_class,
            trimester: trimester,
            max_enrollment: 25
          )
        end
      end

      it "returns a list of courses" do
        get '/courses'

        expect(response.body).to include('Coding Class 1')
        expect(response.body).to include('Coding Class 2')
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end

    context "students exist" do
      let!(:course) do

        coding_class = CodingClass.create!(
          title: "Coding Class 1",
          description: "Class Description1"
        )
        trimester = Trimester.create!(
          term: "Term 1",
          year: "2025",
          start_date: "2025-01-01",
          end_date: "2025-01-01",
          application_deadline: "2025-01-01"
        )
        Course.create!(
          coding_class: coding_class,
          trimester: trimester,
          max_enrollment: 25
        )
      end

      before do
        (1..2).each do |i|
          Student.create!(
            first_name: "StudentFirst#{i}",
            last_name: "StudentLast#{i}",
            email: "#{i}@example.com"
          ).tap do |student|
            Enrollment.create!(
              student: student,
              course: course
            )
          end
        end
      end
      it "returns a list of students for a course" do
        get "/courses/#{course.id}"

        expect(response.body).to include('StudentFirst1')
        expect(response.body).to include('StudentLast1')
        expect(response.body).to include('StudentFirst2')
        expect(response.body).to include('StudentLast2')
      end
    end
  end
end
