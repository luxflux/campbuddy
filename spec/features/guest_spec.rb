require 'rails_helper'

feature 'Guest View' do
  background do
    visit root_url
    click_link 'Als Gast einloggen'
  end

  let(:event) { FactoryGirl.create :event }

  scenario 'allows listing events catalog' do
    Timecop.travel Setting.camp_start + 1.day
    event.touch
    visit catalog_events_url
    expect(page).to have_content event.title
  end

  describe 'event details' do
    background do
      visit event_path(event)
    end

    scenario 'allows opening an event detail view' do
      expect(page).to have_content event.title
    end

    scenario 'it hides the attendance bar' do
      expect(page).to_not have_css('.checked')
      expect(page).to_not have_css('.unchecked')
    end

    scenario 'it hides the attendees' do
      expect(page).to_not have_css('.partipicants')
    end

    scenario 'it hides the owner' do
      expect(page).to_not have_css('li.owner')
    end
  end

  describe 'main navigation' do
    scenario 'has only logout' do
      expect(page).to_not have_css('nav.main.five')
      expect(page).to have_css('nav.main.single')
    end
  end
end
