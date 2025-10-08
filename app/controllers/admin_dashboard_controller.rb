class AdminDashboardController < ApplicationController
  before_action :require_admin
  def index
    @current_trimester = Trimester.where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first
    @upcoming_trimester = Trimester.where("start_date > ? AND start_date <= ?", Date.today, Date.today + 6.months).order(:start_date).first
    @past_trimesters = Trimester.where("end_date < ?", Date.today).order(end_date: :desc)
  end
end
