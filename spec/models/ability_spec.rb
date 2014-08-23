require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'for an admin' do
    let(:user) { instance_double(User) }

    before do
      allow(user).to receive(:admin?).and_return(true)
      allow(user).to receive(:user?).and_return(false)
    end

    specify { expect(subject).to be_able_to(:manage, :all) }
  end

  context 'as normal user' do
    let(:user) { instance_double(User) }

    before do
      allow(user).to receive(:admin?).and_return(false)
      allow(user).to receive(:user?).and_return(true)
    end

    specify { expect(subject).to_not be_able_to(:manage, :all) }
    specify { expect(subject).to be_able_to(:read, Workshop) }
  end

  context 'as guest' do
    let(:user) { nil }

    specify { expect(subject).to_not be_able_to(:manage, :all) }
  end
end
