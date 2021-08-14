require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let!(:user) { FactoryBot.create(:user, username: 'Foobius66') }

    it "authenticates the client" do
      post '/api/v1/authenticate', params: { username: user.username, password: '123456' }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({
        'token' => '123'
      })
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: {password: '123456' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
        'error' => 'param is missing or the value is empty: username'
      })

    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'Foobius66' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end
  end
end
