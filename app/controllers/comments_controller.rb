class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        # binding.pry
        @comment.user = current_user
        if params[:is_comment] == "true"
            parent_comment = Comment.find(params[:id])
            @comment.submission = Submission.find(parent_comment.submission.id)
        else
            @comment.submission = Submission.find(params[:id])
        end
        
        redirect_to item_url(:id => params[:id])
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
