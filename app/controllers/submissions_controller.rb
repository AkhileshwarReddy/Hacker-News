class SubmissionsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :hidden_submissions]
    before_action :set_submission, only: [:hide]

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

        @submission.is_showhn = @submission.title.start_with?("Show HN:")
        @submission.is_askhn = @submission.title.start_with?("Ask HN:");
        
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
        if user_signed_in?
            @submissions = Submission.newest.where.not(id: current_user.hidden_submissions)
        else
            @submissions = Submission.newest
        end
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

    def hide
        if params[:how] == "un"
            current_user.hidden_submissions.delete(@submission.id)
        else
            current_user.hidden_submissions.push(@submission.id)
        end

        if current_user.save
            redirect_to hidden_path if params[:how] == "un" else newest_path
        end
    end

    def hidden
        @no_hidden_items = false
        if current_user.hidden_submissions.count > 0
            @submissions = Submission.where(id: current_user.hidden_submissions)
        else
            @no_such_item = true
        end
    end

    def askhn
        @submissions = Submission.newest.where(is_askhn: true)
    end

    def showhn
        @submissions = Submission.newest.where(is_showhn: true)
    end

    def past
        # @submissions = Submission.by_date(params[:day])
    end

    def shownew
        @submissions = Submission.newest
    end

    def submitted
        @no_such_user = false
        if params[:id] == nil
            @no_such_user = true
        else
            @user = User.find_by(username: params[:id])
            if @user == nil
                @no_such_user = true
            else
                @submissions = @user.submissions.order(created_at: :desc)
            end
        end
    end
    
    private
        def submission_params
            params.require(:submission).permit(:title, :url, :text);
        end

        def set_submission
            @submission = Submission.find(params[:id])
        end
end
