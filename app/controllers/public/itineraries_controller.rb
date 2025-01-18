class Public::ItinerariesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user_id = current_user.id
    @itinerary.status = :draft
    if @itinerary.save
      redirect_to edit_index_itinerary_destinations_path(@itinerary), notice: 'しおりタイトルが下書きに保存されました。次は行き先を登録しましょう'
    else
      render:new, alert:'しおり登録に失敗しました。'
    end
  end


  def status_change
    itinerary = Itinerary.find(params[:id])
    redirect_to root_path, alert: '予期せぬ操作です！' unless itinerary.user == current_user
    # ステータスの取得 (フォームからのリクエストとリンクからのリクエストに対応)
    status = params[:itinerary]&.[](:status) || params[:status]

    case status
      when 'published'
        itinerary.update(status: :published)
      when 'unpublished'
        itinerary.update(status: :unpublished)
      else
        itinerary.update(status: :draft)
    end
    redirect_to itinerary_path(itinerary)
  end

  def index
    #全ユーザーの新着投稿一覧、行き先があるしおりのみ抽出するメソッド適用
    @itineraries = Itinerary.includes(:destinations)
                           .with_destinations # 行き先があるしおりのみ抽出(公開中のみ)
                           .order(id: :desc) # 新着順
                           .page(params[:page]) # ページネーション
                           .per(6) # 1ページあたり6件
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @destinations = @itinerary.destinations.ordered 
    @user = @itinerary.user
    @post_comment = PostComment.new
    #itineraryかdestinationのどちらかの最新更新日時取得
    @latest_updated_at = @itinerary.latest_updated_at

    # destinationsの中から最も早い日付と時間のデータを取得
      @map_destinations = @itinerary.destinations
      @earliest = @itinerary.destinations
      .where(day_number: @itinerary.destinations.minimum(:day_number))
      .order(:start_time)
      .first

    #byebug
    #map表示に渡す引数
    respond_to do |format|
      format.html
      format.json # { render json: { data: { items: @destinations_with_address,earliest: @earliest } } }
    end
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
      redirect_to user_path(current_user),notice:'しおりを削除しました'
    else
      redirect_to request.referer.alert:'しおりの削除に失敗しました。'
    end
  end
  
  private

  def itinerary_params
    params.require(:itinerary).permit(:title, :region, :start_time, :day_number, :status, :key_image)
  end

  def correct_user
    @itinerary = current_user.itineraries.find_by_id(params[:id])
    redirect_to root_url if !@itinerary
  end

end
