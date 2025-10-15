class Api::V1::EnrollmentsController < ApplicationController
  def index
    current_date = Date.today
    current_trimester = Trimester.find_by("start_date <= ? AND end_date >= ?", current_date, current_date)
    course = Course.find_by(id: params[:course_id], trimester_id: current_trimester.id)
    enrollments = course.enrollments.includes(:student) if course

    unless course
      render json: { enrollments: [], message: "No course found for the current trimester" }, status: :ok
      return
    end

    enrollments_array = enrollments.map do |enrollment|
      {
        id: enrollment.id,
        student_id: enrollment.student_id,
        student_full_name: enrollment.student.full_name,
        final_grade: enrollment.final_grade
      }
    end
    render json: { enrollments: enrollments_array }, status: :ok
  end
end
