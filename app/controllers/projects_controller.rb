class ProjectsController < ApplicationController
  before_filter :get_user
  before_action :get_offset, :only => [:index]

  def index
    # TODO: dynamic sort column
    render json: @user.projects.order("created_at").offset(@offset)
  end

  def show
    render json: @user.projects.find(params[:id]).to_json()
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

  @@PROJECT_COUNT = 10

  private

  def get_offset
    page = params.permit(:page)[:page]

    page = 1 if !page

    page = page.to_i

    page = 1 if page < 1

    @offset = (page - 1) * @@PROJECT_COUNT
  end

  def get_user
    @user = User.find(params[:user_id])
  end

end
