class SubmissionsController < ApplicationController
  before_action :set_course
  before_action :set_submission, only: %i[ show edit update ]
  before_action :set_lessons, only: %i[ new edit ]
  before_action :set_enrollments, only: %i[ new edit create ]
  before_action :require_mentor, only: %i[ edit update ]
  before_action :require_student, only: %i[ new create ]

  def index
    @submissions = @course.submissions
  end

  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_submissions_path(@course), notice: 'Submission was successfully created'
    else
      @enrollments = @course.enrollments
      @lessons = @course.lessons
      render :new
    end
  end

  # GET /submissions/1/edit
  def edit
  end


  # PATCH/PUT /courses/:course_id/submissions/:id
  def update
    submission_attributes = submission_params.merge({mentor_id: session[:user_id]})
    submission_attributes[:reviewed_at] = Time.current
    if @submission.update(submission_params.merge({mentor_id: session[:user_id]}))
      redirect_to course_submission_path(@course, @submission), notice: "Submission updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:course_id/submissions/:id
  def destroy
  end

  private
    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :pull_request_url, :mentor_id, :review_result)
    end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_submission
    @submission = @course.submissions.find(params[:id])
  end

  def set_lessons
    @lessons = @course.lessons
  end

  def set_enrollments
    @enrollments = @course.enrollments
  end
end
