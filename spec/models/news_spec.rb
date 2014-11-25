require 'rails_helper'

RSpec.describe News, :type => :model do
  it { is_expected.to validate_presence_of :message }
  it { is_expected.to validate_presence_of :visible_until }

  describe '#visible_until validations' do
    let(:news) { FactoryGirl.build :news, visible_until: visible_until }

    subject { news }

    context 'before current time' do
      let(:visible_until) { Time.current - 10.minutes }

      it { is_expected.to have(1).error_on(:visible_until) }
    end
  end
end
