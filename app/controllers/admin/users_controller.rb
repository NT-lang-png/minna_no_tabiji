class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @itineraries = @user.itineraries.order(id: :desc).page(params[:page])
  end

  def edit
  end

  def update
  end
  
end
