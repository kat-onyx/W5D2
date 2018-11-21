class PostsController < ApplicationController
  helper_method :list_all_children
  def new
    @subs = Sub.all
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to subs_url
  end

  def list_all_children(parent_comment)
    return "" if parent_comment.empty?

    result = "<ul>".html_safe
      parent_comment.each do |parent|
        result += "<li><a href=\"#{comment_url(parent)}\">#{parent.content}</a></li>".html_safe
        result += list_all_children(parent.child_comments)
      end
    result += "</ul>".html_safe
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids => [])
  end
end
