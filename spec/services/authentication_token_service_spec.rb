require 'rails_helper'

describe AuthenticationTokenService do
  USER_ID = 1
  describe '.call' do
    let(:token) { described_class.call(USER_ID) }

    it 'returns an authenticaton token' do
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      expect(decoded_token).to eq(
        [
          { "user_id" => USER_ID }, # payload
          { "alg" => "HS256" } # header
        ]
      )
    end
  end
end
