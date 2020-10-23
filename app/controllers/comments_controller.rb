class CommentsController < ApplicationController
    before_action :set_comment, only: [:update, :destroy]

    def index
        @comments = comment.all
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        if @comment.save
            redirect_to route_path(@comment.route), notice: "comment created"
        else
            render :new
        end
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
        @comment = comment.find(params[:id])
    end
    
    def route_params
        params.require(:route).permit(:content)
    end
end
