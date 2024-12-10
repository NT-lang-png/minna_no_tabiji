class Public::DestinationsController < ApplicationController

  def new
    @itinerary = Itinerary.find(params[:itinerary_id])
    @destinations = @itinerary.destinations.ordered
    @destination = Destination.new
    @max_day = @itinerary.day_number
  end
  
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @destination = @itinerary.destinations.build(destination_params)
    @destination.itinerary_id = @itinerary.id
    if @destination.save
      redirect_to request.referer, notice: "行き先を追加しました"
    else
      redirect_to request.referer,alert:'行き先追加に失敗しました。'
    end
  end

  def destroy
    destination = Destination.find(params[:id])
    if destination.destroy
      redirect_to request.referer, notice: '行き先を削除しました。'
    else
      redirect_to request.referer, alert: '削除に失敗しました。'
    end
  end

  def edit
  end


  def update
  end

  private

  def destination_params
    params.require(:destination).permit(:itinerary_id, :day_number, :start_time, :end_time, :name, :address, :notes)
  end

end
