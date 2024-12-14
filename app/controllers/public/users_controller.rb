class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit, :update]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to show_users_path(@user), notice: 'プロフィールが更新されました'
    else
      @user.reload
      flash.now[:alert]='プロフィールの更新に失敗しました。'
      render:edit
      #redirect_to request.referer,alert: '更新に失敗しました'
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @itineraries = @user.itineraries.order(id: :desc).page(params[:page]).per(4)
    else
      @itineraries = @user.itineraries.with_destinations.order(id: :desc).page(params[:page]).per(4)
    end
  end

  def confirm
    @user = current_user
  end

  def withdraw
    @user = current_user
    if @user.update(is_active: false)
      reset_session
      redirect_to root_path
    else
      redirect_to request.referer,alert: '情報送信に失敗しました'
    end
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:handle_name, :email, :introduction, :image, :is_active)
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path if !@user || @user != current_user
  end
end
