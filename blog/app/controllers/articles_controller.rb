class ArticlesController < ApplicationController
    # http_basic_authenticate_with name: "123", password: "123", except: [:index, :show]
    
    before_action :require_login
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
    
    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end
    
    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    def create
        @article = current_user.articles.build(article_params)

        if @article.save
            redirect_to @article
        else
            render 'new', status: :unprocessable_entity
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :text, :status)
        end

        def set_article
            @article = Article.find_by(id: params[:id])
            render 'public/404' if @article.nil?
        end

        def require_login
            redirect_to login_path unless session["user_id"]
        end

        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end
end
