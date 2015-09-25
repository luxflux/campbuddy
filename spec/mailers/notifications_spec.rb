require 'rails_helper'

RSpec.describe Notifications, type: :mailer do
  let(:user) { FactoryGirl.create :user }

  describe 'invitation' do
    before do
      user.invite
    end

    let(:mail) { Notifications.invitation(user, Camp.current) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Wintercamp 2015 | Einladung zum Camp Buddy')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['buddy@oneyouth.ch'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('<h1>Hoi du! Klick da: http://test.example.org/onboarding/start')
    end
  end
end
