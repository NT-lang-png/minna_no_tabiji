class Public::TutorialsController < ApplicationController
  
  def tutorial
    @user = current_user
  end

end
