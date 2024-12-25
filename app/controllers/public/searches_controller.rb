class Public::SearchesController < ApplicationController
  
  def search
    @content = params[:content]

    record_itineraries = Itinerary.search_for(@content)
    @itineraries = record_itineraries.with_destinations.order(id: :desc).page(params[:page]).per(6)
  end

  def search_region
    @region = params[:region]
    @region_name = I18n.t("enums.itinerary.region.#{@region}")
    record_itineraries = Itinerary.search_region_for(@region)
    @itineraries = record_itineraries.with_destinations.order(id: :desc).page(params[:page]).per(6)
  end

  
end
