class WorksController < ApplicationController
  before_action :find_individual_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show
    if @work.nil?
      flash[:error] = "Unknown work"
      redirect_to works_path
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_individual_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
