require 'rails_helper'

feature 'Onboarding' do
  context 'user has been invited' do
    let(:user) { FactoryGirl.create :user }

    before do
      user.invite
    end

    scenario 'allows setting the password' do
      visit onboarding_start_url(user.invitation_token)
      fill_in 'Passwort', with: 'tralala'
      click_on 'Passwort setzen'

      expect(page).to have_content 'News Feed'
    end

    scenario 'does not accept an empty password' do
      visit onboarding_start_url(user.invitation_token)
      click_on 'Passwort setzen'

      expect(page).to have_content 'muss ausgefüllt werden'
    end

    scenario 'does not accept an empty password again' do
      visit onboarding_start_url(user.invitation_token)

      3.times do
        click_on 'Passwort setzen'
        expect(page).to have_content 'muss ausgefüllt werden'
      end
    end
  end

  context 'random access' do
    scenario 'denies access' do
      visit onboarding_start_url('asdasd')
      expect(page).to have_content 'Als Gast einloggen'
    end
  end
end
