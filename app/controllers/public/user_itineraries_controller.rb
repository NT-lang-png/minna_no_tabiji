class Public::UserItinerariesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    #各ユーザーの新着投稿一覧
    @user = User.find(params[:user_id])
    @itineraries = @user.itineraries.with_destinations.order(id: :desc).page(params[:page]).per(6)
  end
  
end
