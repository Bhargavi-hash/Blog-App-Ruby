class ApplicationController < ActionController::Base

    helper_method :current_user

    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    private
    def render_404
        render file: "#{Rails.root}/public/404.html", status: :not_found
    end
end
