class Api::V1::StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @student = Student.new(student_params)

    if @student.save
      render json: { student: @student, message: "Student was successfully created." }, status: :created
    else
      render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email)
  end
end