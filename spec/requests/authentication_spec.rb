require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let!(:user) { FactoryBot.create(:user, username: 'Foobius66', password: '123456') }

    it "authenticates the client" do
      post '/api/v1/authenticate', params: { username: user.username, password: user.password }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({
        'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w'
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
      post '/api/v1/authenticate', params: { username: user.username }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: "incorrect" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
