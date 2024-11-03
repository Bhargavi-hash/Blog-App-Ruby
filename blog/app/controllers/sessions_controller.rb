class SessionsController < ApplicationController

    def new
        redirect_to root_path if session[:user_id]
    end

    def create
        user = User.find_or_create_by(username: params[:username])
        session[:user_id] = user.id
        redirect_to root_path
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path
    end
end
