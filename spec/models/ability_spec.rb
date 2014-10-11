require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'for an admin' do
    let(:user) { FactoryGirl.create(:user, admin: true) }

    specify { expect(subject).to be_able_to(:manage, :all) }
  end

  context 'as normal user' do
    let(:user) { FactoryGirl.create(:user, admin: false) }
    let(:workshop) { FactoryGirl.create(:workshop) }
    let(:owned_workshop) { FactoryGirl.create(:workshop, owner: user) }

    specify { expect(subject).to_not be_able_to(:manage, :all) }

    specify { expect(subject).to be_able_to(:read, Workshop) }
    specify { expect(subject).to_not be_able_to(:update, workshop) }
    specify { expect(subject).to be_able_to(:update, owned_workshop) }
    specify { expect(subject).to_not be_able_to(:destroy, owned_workshop) }
  end

  context 'as guest' do
    let(:user) { nil }

    specify { expect(subject).to_not be_able_to(:manage, :all) }
    specify { expect(subject).to_not be_able_to(:read, Workshop) }
  end
end
