require 'rails_helper'

RSpec.describe Camp, type: :model do
  let(:camp) { FactoryGirl.build :camp }
  it 'creates a tenant after creation' do
    expect(Apartment::Tenant).to receive(:create).with('example_example_test')
    camp.save!
  end

  it 'sets the schema name before validation' do
    expect { camp.valid? }.to change { camp.schema_name }
  end
end
