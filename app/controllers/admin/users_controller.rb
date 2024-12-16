class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end
  
end
