require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  context 'validations' do
    context 'normal user' do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_presence_of :password }
      it { is_expected.to validate_presence_of :firstname }
      it { is_expected.to validate_presence_of :name }
    end

    context 'a guest' do
      subject { User.new(guest: true) }

      it { is_expected.to_not validate_presence_of :email }
      it { is_expected.to_not validate_presence_of :password }
      it { is_expected.to_not validate_presence_of :firstname }
      it { is_expected.to_not validate_presence_of :name }
    end
  end

  describe '#fullname' do
    subject { user.fullname }
    specify { expect(subject).to eq("#{user.firstname} #{user.name}") }
  end

  describe '#events' do
    subject { user.events }

    let!(:mandatory_event) { FactoryGirl.create(:event, mandatory: true, title: 'Mandatory') }
    let!(:owned_event) { FactoryGirl.create(:event, owner: user, title: 'Owned Event') }
    let(:group_event) { FactoryGirl.create(:event, title: 'Group Event') }
    let(:event) { FactoryGirl.create(:event, title: 'Event') }
    let(:group_as_leader_event) { FactoryGirl.create(:event, title: 'Group As Leader Event') }

    let(:group) { FactoryGirl.create(:group) }
    let(:group_as_leader) { FactoryGirl.create(:group, leader: user) }

    before do
      user.save!
      user.self_attended_events << event

      user.groups << group
      group.events << group_event

      group_as_leader.events << group_as_leader_event
    end

    it { is_expected.to include mandatory_event }
    it { is_expected.to include group_event }
    it { is_expected.to include event }
    it { is_expected.to include owned_event }
    it { is_expected.to include group_as_leader_event }

    it 'handles duplication' do
      user.events << owned_event
      group.events << owned_event
      expect(subject.ids.sort).to eq(subject.ids.uniq.sort)
    end
  end

  describe '#send_mail=' do
    let(:send_mail) { nil }

    subject { FactoryGirl.build :user }

    before do
      subject.send_mail = send_mail
    end

    context 'a new user' do
      context 'true' do
        let(:send_mail) { true }

        it 'sends the invitation mail' do
          expect { subject.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      context 'false' do
        let(:send_mail) { false }

        it 'does not send invitation mail' do
          expect { subject.save }.to_not change { ActionMailer::Base.deliveries.count }
        end
      end

      context 'nil' do
        let(:send_mail) { nil }

        it 'does not send invitation mail' do
          expect { subject.save }.to_not change { ActionMailer::Base.deliveries.count }
        end
      end
    end

    context 'an existing user' do
      subject { FactoryGirl.create :user }

      context 'true' do
        let(:send_mail) { true }

        it 'does not send invitation mail' do
          expect { subject.save }.to_not change { ActionMailer::Base.deliveries.count }
        end
      end
    end
  end
end
