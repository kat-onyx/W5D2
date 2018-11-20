class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:post][:sub_id]
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])

  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update(post_params)

    end
  end

  def show
  end

  def destroy
  end
end
