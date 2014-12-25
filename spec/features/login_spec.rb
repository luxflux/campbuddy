require 'rails_helper'

feature 'Login' do
  context 'as user' do
    let(:user) { FactoryGirl.create :user, password: 'secure' }

    scenario 'login succeeds' do
      visit root_url
      fill_in 'E-Mail', with: user.email
      fill_in 'Passwort', with: 'secure'

      click_button 'Einloggen'

      expect(page).to_not have_button 'Einloggen'
      expect(page).to have_content 'News Feed'
    end

    scenario 'login fails' do
      visit root_url
      fill_in 'E-Mail', with: user.email
      fill_in 'Passwort', with: 'wrong'

      click_button 'Einloggen'

      expect(page).to have_button 'Einloggen'
    end
  end

  context 'as guest' do
    scenario 'login is allowed' do
      visit root_url

      click_link 'Als Gast einloggen'

      expect(page).to have_content 'Events'
    end
  end

  describe 'main navigation on login screen' do
    scenario 'is not displayed' do
      visit root_url
      expect(page).to_not have_css('nav.main')
    end
  end

  context 'as logged in user' do
    it 'redirects to the root url' do
      visit sign_in_url
      click_link 'Als Gast einloggen'
      visit sign_in_url
      expect(current_path).to eq(catalog_events_path)
    end
  end
end
