class CommentsController < ApplicationController
    # http_basic_authenticate_with name: "123", password: "123", only: :destroy
    before_action :require_login

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
            redirect_to post_path(@post)
        else
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace("new_comment_form", partial: "comments/form", locals: { post: @post, comment: @comment }) }
                format.html { render 'posts/show', status: :unprocessable_entity }
            end
            # render 'posts/show', status: :unprocessable_entity
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post), status: :see_other
    end

    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :status)
        end

        def require_login
            redirect_to login_path unless session[:user_id]
        end
    

end
