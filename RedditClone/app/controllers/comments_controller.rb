class CommentsController < ApplicationController
  helper_method :list_all_children
  before_action :require_login

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.parent_comment_id = params[:parent_comment_id]

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
