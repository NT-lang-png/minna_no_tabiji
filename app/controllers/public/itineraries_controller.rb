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
      render :new, alert:'投稿に失敗しました。'
    end
  end

  def private_post
  end

  def private_patch
  end

  def index
    @itineraries = Itinerary.with_destinations
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    if params[:completed] == "true"
      flash.now[:notice] = '投稿が完了しました！'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def itinerary_params
    params.require(:itinerary).permit(:title, :region, :start_time, :day_number )#destinations_attributes: [:id, :day_number, :start_time, :name, :_destroy])
  end
end
