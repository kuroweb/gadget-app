class V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all

    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_content_params)
    sent_tags = post_tags_params[:tags] === nil ? [] : post_tags_params[:tags]
    if @post.save
      @post.save_tag(sent_tags)
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    sent_tags = post_tags_params[:tags] === nil ? [] : post_tags_params[:tags]
    if @post.update(post_content_params)
      @post.save_tag(sent_tags)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_content_params
      params.require(:post).permit(:description, :user_id, images: [])
    end

    def post_tags_params
      params.require(:post).permit(tags: [])
    end
end
