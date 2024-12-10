class Public::MyController < ApplicationController
  def index
    #カレントユーザーの新着投稿一覧
    @itineraries = Itinerary.order(id: :desc).page(params[:page]).per(6)
  end
end
