class CommentReflex < ApplicationReflex
  def create
    comment = Comment.new(content: params[:comment][:content])
    comment.user = User.find(element.dataset.user)
    comment.route = Route.find(params[:id])
    comment.save
  end
end