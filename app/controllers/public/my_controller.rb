class Public::MyController < ApplicationController

  before_action :authenticate_user!
  
  def index
    #カレントユーザーの新着投稿一覧
    @itineraries = current_user.itineraries.order(id: :desc).page(params[:page]).per(6)
  end
end
