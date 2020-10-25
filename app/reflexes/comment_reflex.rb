class CommentReflex < ApplicationReflex
  def create
    @comment = Comment.new(content: params[:comment][:content])
    @comment.user = User.find(element.dataset.user)
    @comment.route = Route.find(params[:id])
    @comment.save if @comment.valid?
  end

  def destroy
    comment = Comment.find(element.dataset.comment_id)
    comment.destroy
  end
end