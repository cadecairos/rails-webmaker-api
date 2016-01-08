class UsersController < ApplicationController
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
end
