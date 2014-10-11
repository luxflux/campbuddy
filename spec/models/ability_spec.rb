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
    let(:workshop) { FactoryGirl.create(:workshop) }
    let(:owned_workshop) { FactoryGirl.create(:workshop, owner: current_user) }

    specify { should_not be_able_to(:manage, :all) }

    describe 'Workshop' do
      it { should be_able_to(:read, Workshop) }
      it { should_not be_able_to(:update, workshop) }
      it { should be_able_to(:update, owned_workshop) }
      it { should_not be_able_to(:destroy, owned_workshop) }
    end

    describe 'Attendance' do
      let!(:own_attendance) { FactoryGirl.create(:attendance, user: current_user, workshop: workshop) }
      let(:others_attendance) { FactoryGirl.create(:attendance) }
      let(:others_attendance_same_workshop) { FactoryGirl.create(:attendance, workshop: workshop) }

      it { should be_able_to(:read, own_attendance) }
      it { should be_able_to(:read, others_attendance_same_workshop) }
      it { should_not be_able_to(:read, others_attendance) }
    end
  end

  context 'as guest' do
    let(:current_user) { nil }

    it { should_not be_able_to(:manage, :all) }
    it { should_not be_able_to(:read, Workshop) }
    it { should_not be_able_to(:read, Attendance) }
  end
end
