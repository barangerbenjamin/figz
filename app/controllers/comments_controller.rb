class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  def index
    @comments = comment.all
  end

  def update
    if @comment.update(comment_params)
      redirect_to route_path(@comment.route), notice: "comment updated"
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to route_path(@comment.route), notice: "comment destroyed"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
