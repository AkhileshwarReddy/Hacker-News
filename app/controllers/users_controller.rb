class UsersController < ApplicationController
    before_action :set_user, only: [:update]

    def user
        @no_such_user = false
        if params[:id] == nil
            @no_such_user = true
        else
            @user = User.find_by(username: params[:id])
        end
    end

    def update
        @user.update(user_params)
        redirect_to user_path(:id => @user.username)
    end

    private
        def user_params
            params.require(:user).permit(:about, :email, :showdead, :noprocrast, :max_visit, :minaway, :delay)
        end

        def set_user
            @user = User.find_by(email: params[:user][:email])
        end
end
