class RelationshipsController < ApplicationController
  before_action :load_relationship, only: [:update, :destroy]
  before_action :verify_relationship, only: [:update, :destroy]

  def index
    @relationships = current_user.relationships
  end

  def create
    @relationship = Relationship.new permitted_params

    if @relationship.save
      render :show
    else
      render json: {error: @relationship.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    if @relationship.update_attributes(permitted_params)
      render :show
    else
      render json: {error: @relationship.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    render json: @relationship.destroy
  end

  private

  def verify_relationship
    if @relationship.user_1 != current_user.id && @relationship.user_2 != current_user.id
      render json: {error: ["You are not permitted to #{params[:action]} a resource that does not belong to you"]}, status: :forbidden
    end
  end

  def permitted_params
    params_hash = params.require(:relationship).permit(:status, user: [:email])
    if params[:action] == 'create'
      params_hash.delete :status
      user = params_hash.delete :user
      params_hash[:user_2] = User.find_by(email: user[:email]).id
    end

    params_hash[:user_1] = current_user.id

    if status = params_hash[:status]
      params_hash[:status] = Relationship::STATUS[status.to_sym]
    end

    params_hash
  end

  def load_relationship
    @relationship = Relationship.find(params[:id])
  end
end
