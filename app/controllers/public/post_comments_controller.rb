class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    itinerary = Itinerary.find(params[:itinerary_id])
    post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.itinerary_id = itinerary.id
    if post_comment.save
      redirect_to request.referer,notice:'コメントを投稿しました。'
    else
      redirect_to request.referer,alert:'コメント投稿に失敗しました。'
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    if post_comment.destroy
      redirect_to request.referer,notice:'コメントを削除しました。'
    else
      redirect_to request.referer,alert:'コメント削除に失敗しました。'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
