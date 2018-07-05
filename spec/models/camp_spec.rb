require 'rails_helper'

RSpec.describe Camp, type: :model do
  let(:camp) { FactoryBot.build :camp }

  it { is_expected.to validate_presence_of(:schema_name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subdomain) }
  it { is_expected.to validate_presence_of(:organization) }
  it { is_expected.to validate_presence_of(:welcome_text) }
  it { is_expected.to validate_presence_of(:welcome_mail) }
  it { is_expected.to validate_presence_of(:starts) }
  it { is_expected.to validate_presence_of(:ends) }
  it { is_expected.to validate_presence_of(:registration_opens) }
  it { is_expected.to validate_presence_of(:reply_to) }

  it 'creates a tenant after creation' do
    expect(Apartment::Tenant).to receive(:create).with('127_0_0_1')
    camp.save!
  end

  it 'sets the schema name before validation' do
    expect { camp.valid? }.to change { camp.schema_name }
  end
end
