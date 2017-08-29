class FriendsController < ApplicationController
  def index
    @friendships = current_user.friendships
  end

  def find
    # TODO: improve search criteria. Move to service class
    @users = User.where.not(id: current_user.id).where('users.first_name like ? or users.last_name like ?', "#{params[:q]}%", "#{params[:q]}%")
  end

  def requests
    @requests = current_user.friend_requests.pending_status.includes(:user)
  end

  def accept
    @request = current_user.friend_requests.find(params[:id])
    @request.accepted_status!
    current_user.friendships.create(friend: @request.user, status: :accepted)
    redirect_to action: :index
  end

  def add
    @friend = User.where.not(id: current_user.id).find(params[:id])
    current_user.friendships.create(friend: @friend)
    redirect_to action: :index
  end

  def reject
    @friendship = current_user.friendships.find(params[:id])
    @friendship.pair&.rejected_status!
    @friendship.destroy
    redirect_to action: :index
  end
end
