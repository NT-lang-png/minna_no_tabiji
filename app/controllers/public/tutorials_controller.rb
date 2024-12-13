class Public::TutorialsController < ApplicationController
  before_action :authenticate_user!
  
  def tutorial
    @user = current_user
  end

end
