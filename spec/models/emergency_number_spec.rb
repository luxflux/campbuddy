require 'rails_helper'

RSpec.describe EmergencyNumber, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:order) }
  it { is_expected.to validate_presence_of(:color) }
end
