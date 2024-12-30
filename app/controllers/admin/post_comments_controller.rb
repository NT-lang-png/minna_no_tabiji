class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.all.order(id: :desc).page(params[:page])
  end

  
  def destroy
    @post_comment = PostComment.find(params[:id])
    if @post_comment.destroy
      redirect_to request.referer,notice:'コメントを削除しました。'
    else
      redirect_to request.referer,alert:'コメントの削除に失敗しました。'
    end
  end
  
end
