class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    if @post_comment.destroy
      redirect_to request.referer,notice:'コメントを削除しました。'
    else
      redirect_to request.referer,alert:'コメントの削除に失敗しました。'
    end
  end
  
end
