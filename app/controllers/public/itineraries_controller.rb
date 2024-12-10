class Public::ItinerariesController < ApplicationController
  def new
    @itinerary = Itinerary.new
    3.times { @itinerary.destinations.build }
  end

  def create
    @itinerary = current_user.itineraries.build(itinerary_params)
    if @itinerary.save
      redirect_to itinerary_path(@itinerary),notice:'投稿されました。'
    else
      redirect_to request.referer,alert:'投稿に失敗しました。'
    end
  end

  def private_post
  end

  def private_patch
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def itinerary_params
    params.require(:itinerary).permit(:title, :region, :start_time, :day_number, destinations_attributes: [:id, :day_number, :start_time, :name, :_destroy])
  end
end
