class SubmissionsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def new
        @submission = Submission.new
    end

    def create
        @submission = Submission.new(submission_params)
        @submission.user = current_user
        
        if @submission.save
            redirect_to :root
        else
            render 'new'
        end
    end

    def newest
        @submissions = Submission.newest
    end

    private
        def submission_params
            params.require(:submission).permit(:title, :url, :text);
        end
end
