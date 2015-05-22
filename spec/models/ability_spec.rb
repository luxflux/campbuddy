require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  let(:camp) { Setting.current_camp }
  subject(:ability) { Ability.new(current_user, camp) }

  context 'for an admin' do
    let(:current_user) { FactoryGirl.create(:user, admin: true) }

    it { should be_able_to(:manage, :all) }
  end

  context 'as normal user' do
    let(:current_user) { FactoryGirl.create(:user, admin: false) }
    let(:other_user) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event) }
    let(:owned_event) { FactoryGirl.create(:event, owner: current_user) }

    specify { should_not be_able_to(:manage, :all) }

    describe 'Event' do
      it { should be_able_to(:read, Event) }
      it { should be_able_to(:catalog, Event) }

      it { should_not be_able_to(:update, event) }
      it { should be_able_to(:update, owned_event) }

      it { should_not be_able_to(:destroy, Event) }
      it { should_not be_able_to(:destroy, owned_event) }
    end

    describe 'Attendance' do
      let(:own_attendance) do
        FactoryGirl.create(:attendance, user: current_user, event: event)
      end
      let(:other_attendance) do
        FactoryGirl.create(:attendance, user: other_user, event: event)
      end

      it { should be_able_to(:read, Attendance) }
      it { should_not be_able_to(:update, own_attendance) }
      it { should_not be_able_to(:write, other_attendance) }

      context 'during open registration time' do
        before do
          Timecop.travel camp.registration_opens + 5.hours
        end

        it { should be_able_to(:create, own_attendance) }
        it { should be_able_to(:destroy, own_attendance) }
      end

      context 'before open registration time' do
        before do
          Timecop.travel camp.registration_opens - 1.day
        end

        it { should_not be_able_to(:create, own_attendance) }
        it { should_not be_able_to(:destroy, own_attendance) }
      end
    end

    describe 'Group' do
      it { should be_able_to(:read, Group) }
      it { should_not be_able_to(:update, Group) }
      it { should_not be_able_to(:destroy, Group) }
    end

    describe 'Membership' do
      it { should be_able_to(:read, Membership) }
      it { should_not be_able_to(:update, Membership) }
      it { should_not be_able_to(:destroy, Membership) }
    end

    describe 'User' do
      it { should be_able_to(:read, User) }
      it { should be_able_to(:read, other_user) }
      it { should be_able_to(:update, current_user) }
      it { should_not be_able_to(:update, other_user) }
      it { should_not be_able_to(:destroy, current_user) }
      it { should_not be_able_to(:destroy, other_user) }
    end

    describe 'News' do
      it { should be_able_to(:read, News) }

      it { should_not be_able_to(:create, News) }
      it { should_not be_able_to(:update, News) }
      it { should_not be_able_to(:destroy, News) }
    end
  end

  context 'as guest' do
    let(:current_user) { FactoryGirl.create(:user, admin: false, guest: true) }

    it { should_not be_able_to(:manage, :all) }
    it { should_not be_able_to(:read, Event) }
    it { should_not be_able_to(:read, Attendance) }
    it { should_not be_able_to(:read, Group) }
    it { should_not be_able_to(:read, Membership) }
    it { should_not be_able_to(:read, News) }
    it { should be_able_to(:catalog, Event) }
    it { should be_able_to(:show, Event) }
  end
end
