class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog), notice: 'コメント投稿に失敗しました。' }
        format.js { render :index }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
    @comment.destroy
    respond_to do |format|
      if
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog), notice: 'コメント投稿に失敗しました。' }
        format.js { render :index }
      end
    end
  end




  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
end
