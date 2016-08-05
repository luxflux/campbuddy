require 'rails_helper'

RSpec.describe Notifications, type: :mailer do
  let(:user) { FactoryGirl.create :user }

  describe 'invitation' do
    before do
      user.generate_invitation_token
    end

    let(:mail) { Notifications.welcome(user, Camp.current) }

    it 'renders the headers' do
      expect(mail.subject).to eq("#{Camp.current.name} | Einladung zum Camp Buddy")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['buddy@campbuddy.ch'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('<h1>Hoi du! Klick da: http://')
    end
  end
end
