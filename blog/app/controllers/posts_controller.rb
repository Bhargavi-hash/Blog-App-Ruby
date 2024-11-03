class PostsController < ApplicationController

    before_action :require_login
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
    
    def show
        @post = Post.find(params[:id])
        @comment = @post.comments
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end
    
    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])

        if @post.user_id == current_user.id
            @post.destroy
            flash[:success] = "Post successfully deleted."
            redirect_to posts_path
        else
            flash[:error] = "You are not authorized to delete this post."
            redirect_to posts_path(@post)
        end
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            redirect_to @post
        else
            render 'new', status: :unprocessable_entity
        end
    end

    private
        def post_params
            params.require(:post).permit(:title, :text, :status)
        end

        def set_post
            @post = Post.find_by(id: params[:id])
            render file: "#{Rails.root}/public/404.html", status: :not_found if @post.nil?
        end

        def require_login
            redirect_to login_path unless session["user_id"]
        end

        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

        def authorize_user
            redirect_to posts_path, alert: "Not authorized to perform this action" unless @post.user == current_user
        end
          
end
