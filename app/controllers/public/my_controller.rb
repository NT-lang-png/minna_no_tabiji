class Public::MyController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only:[:my_index]
  
  def my_index
    #カレントユーザーの新着投稿一覧、行き先登録が無くてもしおりを全表示する
    @status = params[:status]
    case @status
    when 'published'
      @itineraries = @user.itineraries.where(status: :published).order(id: :desc).page(params[:page]).per(6)
    when 'unpublished'
      @itineraries = @user.itineraries.where(status: :unpublished).order(id: :desc).page(params[:page]).per(6)
    else
      @itineraries = @user.itineraries.where(status: :draft).order(id: :desc).page(params[:page]).per(6)
    end
  end

  private

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path if !@user || @user != current_user
  end

end
