class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def friends
    @status = params[:status] || 'accepted'
    @friends = current_user.friends(status: @status)
  end

  def show
   render json: current_user.as_json(only: [:first_name, :last_name, :email, :id])
  end
end
