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
    @work = Work.new
  end

  def create
    work = Work.new(work_params)

    is_successful = work.save

    if is_successful
      flash[:success] = "Work added successfully"
      redirect_to work_path(work.id)
    else
      work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
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
