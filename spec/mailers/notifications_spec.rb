require 'rails_helper'

RSpec.describe Notifications, :type => :mailer do
  let(:user) { FactoryGirl.create :user }

  describe 'invitation' do
    before do
      user.generate_invitation_token
      user.save!
    end

    let(:mail) { Notifications.invitation(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Einladung zum CampPlaner')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['mail@campplaner.icf.ch'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hallo')
    end
  end
end
