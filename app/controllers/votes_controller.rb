class VotesController < ApplicationController
    before_action :authenticate_user!, only: [:vote, :upvoted]
    before_action :set_params, only: [:vote, :upvoted]

    def vote
        @comment == "t" ? vote_comment : vote_submission
    end

    def upvoted
        @comment == "t" ? upvoted_comments : upvoted_submissions
        # render @comment == "t" ? "votes/comments" : "votes/submissions"
    end

    private
        def set_params
            @id = params[:id]
            @comment = params[:comment]
            @how = params[:how]
            @user = User.find(current_user.id)
        end

        def vote_comment
            comment = Comment.find(@id)
            @how == "up" ? comment.upvotes += 1 : comment.upvotes -= 1
            if comment.save
                if @how == "up"
                    @user.upvoted_comments.push(comment.id)
                else
                    @user.upvoted_comments.delete(comment.id)
                end

                if @user.save
                    redirect_to request.referrer
                end
            end
        end

        def vote_submission
            submission = Submission.find(@id)
            @how == "up" ? submission.upvotes += 1 : submission.upvotes -= 1
            if submission.save
                if @how == "up"
                    @user.upvoted_submissions.push(submission.id)
                else
                    @user.upvoted_submissions.delete(submission.id)
                end

                if @user.save
                    redirect_to request.referrer
                end
            end
        end

        def upvoted_submissions
            @no_such_user = false
            if @user == nil
                @no_such_user = true
            else
                @submissions = Submission.newest.where(id: @user.upvoted_submissions)
            end
            render "votes/submissions"
        end

        def upvoted_comments
            @comments = Comment.order(:created_at).where(id: @user.upvoted_comments)
            render "votes/comments"
        end
end
