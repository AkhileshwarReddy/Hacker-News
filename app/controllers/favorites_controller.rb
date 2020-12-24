class FavoritesController < ApplicationController
    before_action :set_params, only: [:index, :favorites]

    def index
        @user = User.find(current_user.id)
        @comment == "t" ? set_favorite_comment : set_favorite_submission
        @user.save
        redirect_to request.referrer
    end

    def favorites
        @user = User.find_by(username: @id)
        @comment == "t" ? favorite_comments : favorite_submissions
    end

    private
        def set_params
            @id = params[:id]
            @comment = params[:comment]
            @how = params[:how]
        end

        def set_favorite_comment
            comment = Comment.find(@id)
            if @how == "un"
                @user.favorite_comments.delete(comment.id)
            else
                @user.favorite_comments.push(comment.id)
            end
            comment.save
        end

        def set_favorite_submission
            submission = Submission.find(@id)
            if @how == "un"
                @user.favorite_submissions.delete(submission.id)
            else
                @user.favorite_submissions.push(submission.id)
            end
        end

        def favorite_submissions
            @submissions = Submission.where(id: @user.favorite_submissions)
            render "favorites/submissions"
        end

        def favorite_comments
            @comments = Comment.where(id: @user.favorite_comments)
            render "favorites/comments"
        end
end
