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

  describe '.visible' do
    let!(:visible) { FactoryGirl.create :news, visible_until: Time.current + 6.hours }
    let!(:invisible) { FactoryGirl.create :news, visible_until: Time.current + 3.hours }

    subject { News.visible }

    before do
      Timecop.freeze Time.current + 5.hours
    end

    it { is_expected.to eq [visible] }
  end
end
