module Api
  module V1
    class PostsController < ApplicationController

      def index
        @posts = Post.all
        render json: @posts
      end

      def create
        post = Post.new(post_params)

        if post.save
          render json: post, status: :created
        else
          render json: post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Post.find(params[:id]).destroy!

        head :no_content
      end

      private

      def post_params
        params.require(:post).permit(:title, :author, :body)
      end
    end
  end
end