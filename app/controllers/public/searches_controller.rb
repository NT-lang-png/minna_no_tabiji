class Public::SearchesController < ApplicationController
  
  def search
    @content = params[:content]

    record_itineraries = Itinerary.search_for(@content)
    @itineraries = record_itineraries.with_destinations.order(id: :desc).page(params[:page]).per(6)
  end

  
end
