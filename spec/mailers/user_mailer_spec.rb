require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'sent email' do
    let(:user) { FactoryBot.create(:user,
    first_name: 'Jim',
    last_name: 'Morrison',
    email: 'jim_morrison@gmail.com',
    nickname: 'Jimmo',
    password: 'Jimpass'
    ) }
    let(:email) { described_class.with(user: user).user_registered.deliver_now }

    it 'renders the headers' do
      expect(email.subject).to eq('Welcome to the wall app!')
      expect(email.to).to eq(['jim_morrison@gmail.com'])
      expect(email.from).to eq(['vitorguima@gmail.com'])
    end

    it 'renders the body' do
      expect(email.body.encoded).to include("Welcome to the Wall app!, #{user.first_name}")
      expect(email.body.encoded).to include("your login name is: #{user.email}")
      expect(email.body.encoded).to include("To login to the site, just follow this link:")
      expect(email.body.encoded).to include("Thanks for joining and have a great day!")
    end
  end
end
