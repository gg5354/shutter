class FriendsController < ApplicationController
  prepend_before_filter :authenticate_user!

  def index
    @friends = current_user.friends
  end

  def create
    @user1 = Friend.new(user_1: current_user.id, user_2: params[:user_id])
    @user2 = Friend.new(user_1: params[:user_id], user_2: current_user.id)

    Friend.transaction do
      @user1.save!
      @user2.save!
      render :show
    end
  end

  def update_status
    @user1, @user2 = Friend.find_pair(current_user.id, params[:user_id])
    status = Friend::STATUS[params[:status].to_sym]

    Friend.transaction do
      @user1.update_attributes!(status: status)
      @user2.update_attributes!(status: status)
      render :show
    end
  end
end
