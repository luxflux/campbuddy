require 'rails_helper'

feature 'Events Filters' do

  let(:red_category) { FactoryGirl.create :category, name: 'Red Category', identifier: :red }
  let(:blue_category) { FactoryGirl.create :category, name: 'Blue Category', identifier: :blue }
  let(:red_event) { FactoryGirl.create :event, title: 'Red Event', category: red_category, starts_date: '2014-02-01', starts_time: '11:00' }
  let(:blue_event) { FactoryGirl.create :event, title: 'Blue Event', category: blue_category, starts_date: '2014-02-01', starts_time: '11:00' }

  background do
    Timecop.travel '2014-02-01 04:00:00'
    red_event.save!
    blue_event.save

    visit sign_in_path
    click_link 'Als Gast einloggen'
  end

  scenario 'allows filtering the events', js: true do
    expect(page).to have_content red_event.title
    expect(page).to have_content blue_event.title

    click_on 'Red Category'
    expect(page).to have_content red_event.title
    expect(page).to_not have_content blue_event.title

    click_on 'Blue Category'
    expect(page).to_not have_content red_event.title
    expect(page).to have_content blue_event.title

    click_on 'Blue Category'
    expect(page).to have_content red_event.title
    expect(page).to have_content blue_event.title
  end
end