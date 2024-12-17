class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @content = params[:content]

    record_itineraries = Itinerary.search_for(@content)
    @itineraries = record_itineraries.page(params[:page])
  end
end
