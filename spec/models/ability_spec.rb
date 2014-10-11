require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'for an admin' do
    let(:user) { FactoryGirl.create(:user, admin: true) }

    it { should be_able_to(:manage, :all) }
  end

  context 'as normal user' do
    let(:user) { FactoryGirl.create(:user, admin: false) }
    let(:workshop) { FactoryGirl.create(:workshop) }
    let(:owned_workshop) { FactoryGirl.create(:workshop, owner: user) }

    specify { should_not be_able_to(:manage, :all) }

    describe 'Workshop' do
      it { should be_able_to(:read, Workshop) }
      it { should_not be_able_to(:update, workshop) }
      it { should be_able_to(:update, owned_workshop) }
      it { should_not be_able_to(:destroy, owned_workshop) }
    end
  end

  context 'as guest' do
    let(:user) { nil }

    it { should_not be_able_to(:manage, :all) }
    it { should_not be_able_to(:read, Workshop) }
  end
end
