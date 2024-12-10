class Public::MyController < ApplicationController
  def index
    @itineraries = Itinerary.order(id: :desc).page(params[:page]).per(6)
  end
end
