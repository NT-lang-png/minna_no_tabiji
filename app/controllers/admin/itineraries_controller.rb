class Admin::ItinerariesController < ApplicationController
  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.destroy
      redirect_to  admin_path,notice:'しおりを削除しました'
    else
      redirect_to request.referer.alert:'しおりの削除に失敗しました。'
    end
  end
  
end
