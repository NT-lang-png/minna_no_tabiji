class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create, :destroy]
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to user_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to user_path(user)
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(6)
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(6)
  end

  private

  #ゲストログイン機能 フォローに遷移できないようにする
  def ensure_guest_user
    @user = User.find(params[:user_id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ユーザー登録後に操作できるページです。'
    end
  end 

  
end
