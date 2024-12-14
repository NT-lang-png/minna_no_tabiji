class Public::ItinerariesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user_id = current_user.id
    if @itinerary.save
      redirect_to edit_index_itinerary_destinations_path(@itinerary), notice: 'しおりタイトルが登録されました。'
    else
      render:new, alert:'投稿に失敗しました。'
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
  end

  def update
    if @itinerary.update(itinerary_params)
      redirect_to itinerary_path(@itinerary), notice: "しおりが更新されました。"
    else
      @itinerary.reload
      flash.now[:alert]='更新に失敗しました。'
      render:edit
    end
  end

  def destroy
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

  def correct_user
    @itinerary = current_user.itineraries.find_by_id(params[:id])
    redirect_to root_url if !@itinerary
  end

end
