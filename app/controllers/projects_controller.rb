class ProjectsController < ApplicationController
  before_filter :get_user
  before_action :get_offset, :only => [:index]

  @@PROJECT_COUNT = 10

  private

  def get_offset
    page = params.permit(:page)[:page]
    if !page
      page = 1
    end

    page = page.to_i

    if page < 1
      page = 1
    end

    @offset = (page - 1) * @@PROJECT_COUNT
  end

  def get_user
    @user = User.find(params[:user_id])
  end

  public

  def index
    # TODO: dynamic sort column
    render json: @user.projects.order("created_at").offset(@offset)
  end

  def show
    render json: @user.projects.find(params[:id])
  end

  def create
    project_data = params.require(:project).permit([:title, :thumbnail, :description])
    render json: @user.projects.new(project_data)
  end

  def update
    update_data = params.require(:project).permit([:title, :thumbnail, :description])
    render json: @user.projects.find(params[:id]).update(update_data)
  end

  def destroy
    render json: @user.projects.destroy(params[:id])
  end
end
