class LikesController < ApplicationController

  def create
    secret = Secret.find(params[:secret_id])
    like = Like.create(user: current_user, secret: secret)
    redirect_to '/secrets'
  end

  def destroy
    like = Like.find_by_user_id_and_secret_id(current_user.id, params[:secret_id])
    like.destroy!
    redirect_to '/secrets'
  end
end
