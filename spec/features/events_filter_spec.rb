require 'rails_helper'

feature 'Events Filters' do

  let(:red_category) { FactoryGirl.create :category, name: 'Red Category', identifier: :red }
  let(:blue_category) { FactoryGirl.create :category, name: 'Blue Category', identifier: :blue }

  let(:red_event) do
    FactoryGirl.create :event,
      title: 'Red Event',
      category: red_category,
      starts_date: Setting.camp_start,
      starts_time: '11:00'
  end

  let(:blue_event) do
    FactoryGirl.create :event,
      title: 'Blue Event',
      category: blue_category,
      starts_date: Setting.camp_start,
      starts_time: '11:00'
  end

  background do
    Timecop.travel Setting.camp_start
    red_event.save!
    blue_event.save

    visit sign_in_path
    click_link 'Als Gast einloggen'
  end

  scenario 'allows filtering the events', js: true do
    expect(page).to have_content red_event.title.upcase
    expect(page).to have_content blue_event.title.upcase

    page.find('a[data-filter=red]').click
    expect(page).to have_content red_event.title.upcase
    expect(page).to_not have_content blue_event.title.upcase

    page.find('a[data-filter=blue]').click
    expect(page).to_not have_content red_event.title.upcase
    expect(page).to have_content blue_event.title.upcase

    page.find('a[data-filter=blue]').click
    expect(page).to have_content red_event.title.upcase
    expect(page).to have_content blue_event.title.upcase
  end
end
