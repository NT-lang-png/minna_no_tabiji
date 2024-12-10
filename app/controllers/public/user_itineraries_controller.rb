class Public::UserItinerariesController < ApplicationController
  def index
    #userにネストされたitineraries index
    @user = User.find(params[:user_id])
    @itineraries = @user.itineraries.with_destinations.order(id: :desc).page(params[:page]).per(6)
  end
  
end
