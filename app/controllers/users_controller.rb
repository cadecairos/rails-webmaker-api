class UsersController < ApplicationController
  include WebmakerIdentity

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
      WebmakerIdentity.validate_user token, params[:id]
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="User"'
    render json: 'Bad credentials', status: 401
  end
end
