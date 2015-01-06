require 'rails_helper'

feature 'Event View' do
  let(:user) { FactoryGirl.create :user, password: 'secure', admin: false }
  let(:event) { FactoryGirl.create :event }

  background do
    visit sign_in_path
    fill_in 'E-Mail', with: user.email
    fill_in 'Passwort', with: 'secure'
    click_on 'Einloggen'
    visit event_path(event)
  end

  describe 'event details' do

    scenario 'allows opening an event detail view' do
      expect(page).to have_content event.title
    end

    scenario 'it shows the attendees' do
      expect(page).to have_css('.partipicants')
    end

    scenario 'it shows the owner' do
      expect(page).to have_css('li.owner')
    end
  end

  describe 'attendance' do
    context 'event can be attended' do
      scenario 'allows to attend', js: true do
        expect(page).to have_css 'div.partipicate'
        expect(page).to_not have_content('Für alle obligatorisch')
        expect(page).to_not have_content('Gruppenevent')

        expect(page).to_not have_css 'div.partipicate.yes'
        page.find('div.partipicate').click
        expect(page).to have_css 'div.partipicate.yes'
      end
    end

    context 'event is mandatory' do
      let(:event) { FactoryGirl.create :event, mandatory: true }

      scenario 'shows the mandatoryness' do
        expect(page).to_not have_css 'div.partipicate'
        expect(page).to have_content('Für alle obligatorisch')
        expect(page).to_not have_content('Gruppenevent')
      end
    end

    context 'group event' do
      let(:event) { FactoryGirl.create :event, groups_only: true }

      scenario 'shows the group only stuff' do
        expect(page).to_not have_css 'div.partipicate'
        expect(page).to_not have_content('Für alle obligatorisch')
        expect(page).to have_content('Gruppenevent')
      end
    end
  end
end
