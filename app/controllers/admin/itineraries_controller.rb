class Admin::ItinerariesController < ApplicationController
  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.destroy
      redirect_to  admin_path,notice:'投稿を削除しました'
    else
      redirect_to request.referer.alert:'投稿の削除に失敗しました。'
    end
  end
  
end
