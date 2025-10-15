class Api::V1::CoursesController < ApplicationController
  def index
    current_date = Date.today
    current_courses = Course.where(trimester: Trimester.where("start_date <= ? AND end_date >= ?", current_date, current_date))
    courses_array = current_courses.map do |course|
      {
        id: course.id,
        title: course.title,
        application_deadline: course.trimester.application_deadline,
        start_date: course.trimester.start_date,
        end_date: course.trimester.end_date
      }
    end

    render json: { courses: courses_array }, status: :ok
  end
end
