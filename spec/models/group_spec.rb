require 'rails_helper'

describe Group do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :leader }

  describe '#name_with_leader' do
    let(:user) { FactoryGirl.build :user }
    let(:group) { Group.new(name: 'Testgroup') }

    context 'leader not specified' do
      it 'returns the group name' do
        expect(group.name_with_leader).to eq('Testgroup')
      end
    end

    context 'leader specified' do
      before do
        group.leader = user
      end

      it 'returns the group name and the leaders name' do
        expect(group.name_with_leader).to eq("Testgroup (#{user.name})")
      end
    end
  end
end
