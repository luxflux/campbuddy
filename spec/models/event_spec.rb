require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe '.in_future' do
    it 'only shows events in the future' do
      today_passed = FactoryGirl.create(:event, starts: Time.now - 3.hours, ends: Time.now - 1.hour)
      today_future = FactoryGirl.create(:event, starts: Time.now + 3.hours, ends: Time.now + 4.hours)

      expect(Event.in_future).to eq([today_future])
    end
  end

  describe '#mandatory?' do
    context 'mandatory event' do
      let(:event) { FactoryGirl.build(:event, mandatory: true) }
      subject { event.mandatory? }
      it { is_expected.to eq(true) }
    end

    context 'voluntary event' do
      let(:event) { FactoryGirl.build(:event, mandatory: false) }
      subject { event.mandatory? }
      it { is_expected.to eq(false) }
    end
  end

  describe '#attended_by_user?' do
    let(:event) { FactoryGirl.create(:event) }
    let(:user) { FactoryGirl.create(:user) }

    subject { event.attended_by_user?(user) }

    context 'user attends' do
      before { event.users << user }
      it { is_expected.to eq(true) }
    end

    context 'user does not attend' do
      it { is_expected.to eq(false) }
    end
  end

  describe '#max_attendees' do
    context 'with max_attendees specified' do
      let(:event) { FactoryGirl.create(:event, max_attendees: 2) }

      context 'no attendees' do
        describe '#attendance_places_left' do
          subject { event.attendance_places_left }
          it { is_expected.to eq(2) }
        end

        describe '#any_places_left?' do
          subject { event.any_places_left? }
          it { is_expected.to eq(true) }
        end

        describe '#no_places_left?' do
          subject { event.no_places_left? }
          it { is_expected.to eq(false) }
        end
      end

      context 'with one attendee' do
        before do
          event.users << FactoryGirl.create(:user)
        end

        describe '#attendance_places_left' do
          subject { event.attendance_places_left }
          it { is_expected.to eq(1) }
        end

        describe '#any_places_left?' do
          subject { event.any_places_left? }
          it { is_expected.to eq(true) }
        end

        describe '#no_places_left?' do
          subject { event.no_places_left? }
          it { is_expected.to eq(false) }
        end
      end

      context 'full' do
        before do
          event.users << FactoryGirl.create(:user)
          event.users << FactoryGirl.create(:user)
        end

        describe '#attendance_places_left' do
          subject { event.attendance_places_left }
          it { is_expected.to eq(0) }
        end

        describe '#any_places_left?' do
          subject { event.any_places_left? }
          it { is_expected.to eq(false) }
        end

        describe '#no_places_left?' do
          subject { event.no_places_left? }
          it { is_expected.to eq(true) }
        end
      end
    end

    context 'without max_attendees specfied' do
      let(:event) { FactoryGirl.create(:event, max_attendees: nil) }

      context 'no attendees' do
        describe '#attendance_places_left' do
          subject { event.attendance_places_left }
          it { is_expected.to eq(nil) }
        end

        describe '#any_places_left?' do
          subject { event.any_places_left? }
          it { is_expected.to eq(true) }
        end

        describe '#no_places_left?' do
          subject { event.no_places_left? }
          it { is_expected.to eq(false) }
        end
      end

      context 'with one attendee' do
        before do
          event.users << FactoryGirl.create(:user)
        end

        describe '#attendance_places_left' do
          subject { event.attendance_places_left }
          it { is_expected.to eq(nil) }
        end

        describe '#any_places_left?' do
          subject { event.any_places_left? }
          it { is_expected.to eq(true) }
        end

        describe '#no_places_left?' do
          subject { event.no_places_left? }
          it { is_expected.to eq(false) }
        end
      end
    end
  end
end
