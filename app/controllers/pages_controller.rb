class PagesController < ApplicationController
  before_filter :get_user
  before_filter :get_project

  def index
    render json: @project.pages
  end

  private
  def get_user
    @user = User.find(params[:user_id])
    return false if @user.nil?
  end

  def get_project
    @project = Project.find(params[:project_id])
    return false if @user.nil?
  end
end
