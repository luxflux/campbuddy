require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe '.in_future' do

    it 'only shows events in the future' do
      today_passed = FactoryGirl.create(:event, starts: Time.now - 3.hours, ends: Time.now - 1.hour)
      today_future = FactoryGirl.create(:event, starts: Time.now + 3.hours, ends: Time.now + 4.hours)

      expect(Event.in_future).to eq([today_future])
    end
  end
end
