class UsersController < ApplicationController
  before_action :authenticate, exclude: :create

  public

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user_data = params.require(:user).permit([:username, :language])
    render json: User.create(user_data)
  end

  def update
    update_data = params.require(:user).permit([:username, :language])
    render json: User.find(params[:id]).update(update_data)
  end

  def destroy
    render json: User.destroy(params[:id])
  end

  private

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      response = HTTP.accept(:json)
        .auth("token #{token}")
        .get("#{Rails.application.config.id_server_connection_string}/user")

      return false unless response.status == 200

      body_hash = JSON.parse(response.body.to_s)

      return false unless body_hash["id"] == params[:id]

      return true
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="User"'
      render json: 'Bad credentials', status: 401
  end
end
