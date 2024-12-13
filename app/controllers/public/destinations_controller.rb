class Public::DestinationsController < ApplicationController

  before_action :authenticate_user!

  def new
    @itinerary = Itinerary.find(params[:itinerary_id])
    @destinations = @itinerary.destinations.ordered
    @destination = Destination.new
    @max_day = @itinerary.day_number
  end

  #行き先新規追加と編集と削除の画面
  def edit_destinations
    @itinerary = Itinerary.find(params[:itinerary_id]) # しおりを取得
    @destinations = @itinerary.destinations.ordered # 全行き先を取得
    @max_day = @itinerary.day_number # 最大日数
    @destination = Destination.new # デフォルト値
  
    # `action_type` と `destination_id` に基づいてフォームのタイプを切り替える
    if params[:action_type] == 'edit' && params[:destination_id].present?
      begin
        @destination = @itinerary.destinations.find(params[:destination_id]) # 編集対象の行き先を取得
        @form_type = 'edit' # 編集フォーム
      rescue ActiveRecord::RecordNotFound
        # 指定された行き先が見つからない場合の処理
        redirect_to edit_index_itinerary_destinations_path(@itinerary), alert: '指定された行き先は存在しません。'
        return
      end
    else
      @destination = @itinerary.destinations.new # 新規行き先を初期化
      @form_type = 'new' # 新規投稿フォーム
    end
  end

  
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @destination = @itinerary.destinations.build(destination_params)
    @destination.itinerary_id = @itinerary.id
    if @destination.save
      redirect_to edit_index_itinerary_destinations_path(@itinerary),notice: "行き先を追加しました"
    else
      redirect_to request.referer,alert:'行き先追加に失敗しました。'
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:itinerary_id]) # 親のしおりを取得
    @destination = @itinerary.destinations.find(params[:id]) # 削除対象を取得
    if @destination.destroy # 削除

      # 削除後に編集ページにリダイレクト
      redirect_to edit_index_itinerary_destinations_path(@itinerary), notice: '行き先を削除しました。'
    else
      redirect_to request.referer,alert:'行き先削除に失敗しました。'
    end
  end


  def edit #行き先を一つずつ編集できる画面に遷移
    @itinerary = Itinerary.find(params[:itinerary_id])
    @destination = Destination.find(params[:id])
  end

  def edit_destinations
    @itinerary = Itinerary.find(params[:itinerary_id]) # しおりを取得
    @destinations = @itinerary.destinations.ordered # 全行き先を取得
    @max_day = @itinerary.day_number # 最大日数
    @destination = Destination.new # デフォルト値
  
    # `action_type` と `destination_id` に基づいてフォームのタイプを切り替える
    if params[:action_type] == 'edit' && params[:destination_id].present?
      begin
        @destination = @itinerary.destinations.find(params[:destination_id]) # 編集対象の行き先を取得
        @form_type = 'edit' # 編集フォーム
      rescue ActiveRecord::RecordNotFound
        # 指定された行き先が見つからない場合の処理
        redirect_to edit_index_itinerary_destinations_path(@itinerary), alert: '指定された行き先は存在しません。'
        return
      end
    else
      @destination = @itinerary.destinations.new # 新規行き先を初期化
      @form_type = 'new' # 新規投稿フォーム
    end
  end


  def update
    @itinerary = Itinerary.find(params[:itinerary_id])
    @destination = @itinerary.destinations.find(params[:id])
    if @destination.update(destination_params)
      redirect_to edit_index_itinerary_destinations_path(@itinerary),notice: "行き先を更新しました"
    else
      redirect_to request.referer, alert: '行き先の更新に失敗しました。'
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:itinerary_id, :day_number, :start_time, :end_time, :name, :address, :notes)
  end

end
