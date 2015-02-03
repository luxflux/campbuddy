require 'rails_helper'

feature 'Event View' do
  let(:user) { FactoryGirl.create :user, password: 'secure', admin: false }
  let(:event) { FactoryGirl.create :event }

  background do
    Timecop.travel Setting.open_registration

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
      expect(page).to have_content('Leiter')
    end
  end

  describe 'attendance' do
    context 'event can be attended' do
      context 'user does not attend' do
        scenario 'allows to attend', js: true do
          expect(page).to_not have_content('Für alle obligatorisch')
          expect(page).to_not have_content('Gruppenevent')

          expect(page).to_not have_css '.participation .yes'
          expect(page).to have_css '.participation .no'
          page.find('.participation').click
          expect(page).to have_css '.participation .yes'
          expect(page).to_not have_css '.participation .no'
        end
      end

      context 'user attends' do
        background do
          event.self_attended_users << user
          visit event_path(event)
        end

        scenario 'allows to unattend', js: true do
          expect(page).to_not have_content('Für alle obligatorisch')
          expect(page).to_not have_content('Gruppenevent')

          expect(page).to have_css '.participation .yes'
          expect(page).to_not have_css '.participation .no'
          page.find('.participation').click
          expect(page).to_not have_css '.participation .yes'
          expect(page).to have_css '.participation .no'
        end
      end
    end

    context 'event is mandatory' do
      let(:category) { FactoryGirl.create :category, mandatory_events: true }
      let(:event) { FactoryGirl.create :event, category: category }

      scenario 'shows the mandatoriness' do
        expect(page).to_not have_css '.partipicate'
        expect(page).to have_content('Für alle obligatorisch')
        expect(page).to_not have_content('Gruppenevent')
      end
    end

    context 'event is info only' do
      let(:category) { FactoryGirl.create :category, info_events: true }
      let(:event) { FactoryGirl.create :event, category: category }

      scenario 'shows that its info only' do
        expect(page).to_not have_css '.partipicate'
        expect(page).to_not have_content('Für alle obligatorisch')
        expect(page).to have_content('Anmeldung nicht nötig')
        expect(page).to_not have_content('Gruppenevent')
      end
    end

    context 'group event' do
      let(:event) { FactoryGirl.create :event, groups_only: true }

      scenario 'shows the group only stuff' do
        expect(page).to_not have_css '.partipicate'
        expect(page).to_not have_content('Für alle obligatorisch')
        expect(page).to have_content('Gruppenevent')
      end
    end
  end
end
