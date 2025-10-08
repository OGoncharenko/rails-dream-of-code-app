class TrimestersController < ApplicationController
  before_action :trimester, only: [:show, :edit, :update]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @trimesters = Trimester.all
  end

  def show
  end

  def new
    @trimester = Trimester.new
  end

  def create
    @trimester = Trimester.new(trimester_params)
    if @trimester.save
      redirect_to @trimester, notice: 'Trimester was successfully created.'
    else
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @trimester.update(trimester_params)
      redirect_to @trimester, notice: 'Trimester was successfully updated.'
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @trimester = Trimester.find(params[:id])
    @trimester.destroy
    redirect_to root_path, notice: "Trimester was successfully deleted."
  end

  private

  def trimester
    @trimester = Trimester.find(params[:id])
  end

  def trimester_params
    params.require(:trimester).permit(:term, :year, :start_date, :end_date, :application_deadline)
  end
end
