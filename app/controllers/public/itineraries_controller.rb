class Public::ItinerariesController < ApplicationController

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user_id = current_user.id
    if @itinerary.save
      redirect_to new_itinerary_destination_path(@itinerary), notice: 'しおりタイトルが登録されました。'
    else
      redirect_to request.referer, alert:'投稿に失敗しました。'
    end
  end

  def private_post
  end

  def private_patch
  end

  def index
    #全ユーザーの新着投稿一覧
    @itineraries = Itinerary.with_destinations.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @user = @itinerary.user
    if params[:completed] == "true"
      flash.now[:notice] = '投稿が完了しました！'
    end
    
  end

  def edit
    @itinerary = Itinerary.find(params[:id])
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.update(itinerary_params)
      redirect_to itinerary_path(@itinerary), notice: "しおりが更新されました。"
    else
      edirect_to request.referer, alert:'更新に失敗しました。'
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.destroy
      redirect_to  my_itineraries_path(current_user),notice:'しおりを削除しました'
    else
      redirect_to request.referer.alert:'しおりの削除に失敗しました。'
    end
  end
  
  private

  def itinerary_params
    params.require(:itinerary).permit(:title, :region, :start_time, :day_number )#destinations_attributes: [:id, :day_number, :start_time, :name, :_destroy])
  end
end
