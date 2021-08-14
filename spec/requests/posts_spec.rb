require 'rails_helper'

describe 'Posts API', type: :request do
  it 'should return all Posts' do
    FactoryBot.create(:post, title: 'What The Foo', body:'More foo for you.', author:'Monty Berns')
    FactoryBot.create(:post, title: 'Hack the Bar', body:'Another bar bnites the dust.', author:'J.M. Smithers')

    get '/api/v1/posts'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end