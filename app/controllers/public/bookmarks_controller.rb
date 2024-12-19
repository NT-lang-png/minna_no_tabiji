class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @bookmark = current_user.bookmarks.new(itinerary_id:@itinerary.id)
    if @bookmark.save
      redirect_to itinerary_path(@itinerary),notice:'ブックマークに追加しました。'
    else
      redirect_to itinerary_path(@itinerary),alert:'ブックマーク追加に失敗しました。'
    end
  end

  def destroy
    itinerary = Itinerary.find(params[:itinerary_id])
    bookmark = current_user.bookmarks.find_by(itinerary_id:itinerary.id)
    if bookmark.destroy
      redirect_to itinerary_path(itinerary),notice:'ブックマークを削除しました。'
    else
      redirect_to itinerary_path(itinerary),alert:'ブックマーク削除に失敗しました。'
    end
  end
  
end