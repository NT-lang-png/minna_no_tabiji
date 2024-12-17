class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @itineraries = Itinerary.all.order(id: :desc).page(params[:page])
  end
  
end
