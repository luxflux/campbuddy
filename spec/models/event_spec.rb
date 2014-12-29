require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe '.in_future' do
    it 'only shows events in the future' do
      today_passed = FactoryGirl.
        create(:event, starts: Setting.camp_start + 1.hour, ends: Setting.camp_start + 2.hours)
      today_future = FactoryGirl.
        create(:event, starts: Setting.camp_start + 8.hours, ends: Setting.camp_start + 10.hours)

      Timecop.travel Setting.camp_start + 5.hours
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
      before { event.self_attended_users << user }
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
          event.self_attended_users << FactoryGirl.create(:user)
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
          event.self_attended_users << FactoryGirl.create(:user)
          event.self_attended_users << FactoryGirl.create(:user)
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

  describe '#users' do
    let(:user) { FactoryGirl.create(:user, name: 'Normal User') }
    let(:owner) { FactoryGirl.create(:user, name: 'Owner') }
    let(:group_leader) { FactoryGirl.create(:user, name: 'Group Leader') }
    let(:group_member) { FactoryGirl.create(:user, name: 'Group Member') }
    let(:group) { FactoryGirl.create(:group, leader: group_leader) }

    let(:mandatory) { false }
    let(:groups_only) { false }
    let(:event) { FactoryGirl.create(:event, owner: owner, mandatory: mandatory, groups_only: groups_only) }

    subject { event.users }

    before do
      group.users << group_member
      user.save
      owner.save
    end

    context 'mandatory event' do
      let(:mandatory) { true }

      it { is_expected.to include(user) }
      it { is_expected.to include(owner) }
      it { is_expected.to include(group_leader) }
      it { is_expected.to include(group_member) }
    end

    context 'group event' do
      let(:groups_only) { true }

      before do
        event.groups << group
      end

      it { is_expected.to_not include(user) }
      it { is_expected.to include(owner) }
      it { is_expected.to include(group_leader) }
      it { is_expected.to include(group_member) }
    end

    context 'open event' do
      context 'without attendees' do
        it { is_expected.to_not include(user) }
        it { is_expected.to include(owner) }
        it { is_expected.to_not include(group_leader) }
        it { is_expected.to_not include(group_member) }
      end

      context 'with attendees' do
        before do
          event.self_attended_users << user
        end

        it { is_expected.to include(user) }
        it { is_expected.to include(owner) }
        it { is_expected.to_not include(group_leader) }
        it { is_expected.to_not include(group_member) }
      end
    end

    it 'handles duplication' do
      group_leader.events << event
      group.events << event
      expect(subject.ids.sort).to eq(subject.uniq.ids.sort)
    end
  end
end
