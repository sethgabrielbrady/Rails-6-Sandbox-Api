module Api
  module V1
    class PostsController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: [:create, :destroy]

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

      def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end

      def post_params
        params.require(:post).permit(:title, :author, :body)
      end
    end
  end
end