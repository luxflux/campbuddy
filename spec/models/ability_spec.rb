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

      it { should_not be_able_to(:destroy, Event) }
      it { should_not be_able_to(:destroy, owned_event) }
    end

    describe 'Attendance' do
      let(:own_attendance) do
        FactoryGirl.create(:attendance, user: current_user, event: event, mandatory: false)
      end
      let(:mandatory_attendance) do
        FactoryGirl.create(:attendance, user: current_user, event: event, mandatory: true)
      end

      it { should be_able_to(:read, Attendance) }
      it { should_not be_able_to(:update, own_attendance) }
      it { should be_able_to(:destroy, own_attendance) }
      it { should_not be_able_to(:destroy, mandatory_attendance) }
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
  end

  context 'as guest' do
    let(:current_user) { nil }

    it { should_not be_able_to(:manage, :all) }
    it { should_not be_able_to(:read, Event) }
    it { should_not be_able_to(:read, Attendance) }
    it { should_not be_able_to(:read, Group) }
    it { should_not be_able_to(:read, Membership) }
  end
end
