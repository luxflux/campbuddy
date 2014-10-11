require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { Ability.new(current_user) }

  context 'for an admin' do
    let(:current_user) { FactoryGirl.create(:user, admin: true) }

    it { should be_able_to(:manage, :all) }
  end

  context 'as normal user' do
    let(:current_user) { FactoryGirl.create(:user, admin: false) }
    let(:event) { FactoryGirl.create(:event) }
    let(:owned_event) { FactoryGirl.create(:event, owner: current_user) }

    specify { should_not be_able_to(:manage, :all) }

    describe 'Event' do
      it { should be_able_to(:read, Event) }
      it { should_not be_able_to(:update, event) }
      it { should be_able_to(:update, owned_event) }
      it { should_not be_able_to(:destroy, owned_event) }
    end

    describe 'Attendance' do
      let!(:own_attendance) { FactoryGirl.create(:attendance, user: current_user, event: event) }
      let(:others_attendance) { FactoryGirl.create(:attendance) }
      let(:others_attendance_same_event) { FactoryGirl.create(:attendance, event: event) }

      it { should be_able_to(:read, own_attendance) }
      it { should be_able_to(:read, others_attendance_same_event) }
      it { should_not be_able_to(:read, others_attendance) }
    end

    describe 'Group' do
      it { should be_able_to(:read, Group) }
    end
  end

  context 'as guest' do
    let(:current_user) { nil }

    it { should_not be_able_to(:manage, :all) }
    it { should_not be_able_to(:read, Event) }
    it { should_not be_able_to(:read, Attendance) }
    it { should_not be_able_to(:read, Group) }
  end
end
