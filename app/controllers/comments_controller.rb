class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
        unless @comment.blog.user_id == current_user.id
         Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
          message: 'あなたの作成したtopicにコメントが付きました'
         })
        end
         Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
         })
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
