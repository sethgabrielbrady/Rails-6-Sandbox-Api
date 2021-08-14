module Api
  class PostsController < ApplicationController

    def index
      @posts = Post.all
      render json: @posts
    end

    def show
      render json: @posts
    end

    def create
      @post = Post.new(post_params)

      if @post.after_save
        render json: @post, status: :created
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

      # def post_params
      #   params.require(:post).permit(:name)
      # end

  end
end