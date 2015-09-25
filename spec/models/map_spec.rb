require 'rails_helper'

RSpec.describe Map, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:order) }
  it { is_expected.to validate_presence_of(:map) }
end
