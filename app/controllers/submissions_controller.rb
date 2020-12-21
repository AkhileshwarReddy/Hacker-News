class SubmissionsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def new
        @submission = Submission.new
    end

    def create
        if !submission_params[:url].empty? and !submission_params[:text].empty?
            @submission = Submission.new(submission_params.except(:text))
            @comment = Comment.new(content: submission_params[:text])
            @comment.user = current_user
        else
            @submission = Submission.new(submission_params)
        end
        
        @submission.user = current_user
        
        if @submission.save
            if @comment
                @comment.submission = @submission
                @comment.save
            end
            redirect_to :root
        else
            render 'new'
        end
    end

    def newest
        @submissions = Submission.newest
    end

    def display_submission
        @no_such_item = false
        if params[:id] == nil
            @no_such_item = true
        else
            @comment = Comment.new
            @submission = Submission.find(params[:id])
            if @submission == nil
                @no_such_item = true
            end
        end
    end

    private
        def submission_params
            params.require(:submission).permit(:title, :url, :text);
        end
end
