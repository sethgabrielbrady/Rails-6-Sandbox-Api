require 'rails_helper'

describe 'Posts API', type: :request do
  describe 'GET /posts' do
    before do
      FactoryBot.create(:post, title: 'What The Foo', body:'More foo for you.', author:'Monty Berns')
      FactoryBot.create(:post, title: 'Hack the Bar', body:'Another bar bnites the dust.', author:'J.M. Smithers')
    end

    it 'should return all Posts' do
      get '/api/v1/posts'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /posts' do
    it 'should create a new post' do
      expect {
        post '/api/v1/posts', params: { post: {title:'The Test', author:'Bill Hinkle', body:'Much to do about nothing.'} }
      }.to change { Post.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /posts' do
    let!(:post) { FactoryBot.create(:post, title: 'What The Foo', body:'More foo for you.', author:'Monty Berns') }

    it 'should delete a post' do
      expect {
        delete "/api/v1/posts/#{post.id}"
      }.to change { Post.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
