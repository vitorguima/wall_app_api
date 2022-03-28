require 'rails_helper'

describe AuthenticationTokenService do
  describe '.decode' do
    let(:user) { FactoryBot.create(:user,
      first_name: 'Jim',
      last_name: 'Morrison',
      email: 'jim_morrison@gmail.com',
      nickname: 'Jimmo',
      password: 'Jimpass'
    ) }
    let(:token) { described_class.encode(user.id) }

    it 'returns an authentication token' do
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      expect(decoded_token).to eq([
        { 'user_id' => user.id },
        { 'alg' => described_class::ALGORITHM_TYPE }
      ])
    end
  end
end
