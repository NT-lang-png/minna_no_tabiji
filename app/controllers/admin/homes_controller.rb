class Admin::HomesController < ApplicationController
  def top
    @itineraries = Itinerary.all.order(id: :desc).page(params[:page])
  end
  
end
