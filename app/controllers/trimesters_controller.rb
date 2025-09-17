class TrimestersController < ApplicationController
  before_action :trimester, only: [:show, :edit, :update]

  def index
    @trimesters = Trimester.all
  end

  def show
  end

  def edit
  end

  def update
    if trimester.update(trimester_params)
      redirect_to @trimester, notice: 'Trimester was successfully updated.'
    else
      render :edit, status: :bad_request
    end
  end

  private

  def trimester
    @trimester = Trimester.find(params[:id])
  end

  def trimester_params
    params.require(:trimester).permit(:application_deadline)
  end
end