require 'rails_helper'
require 'carrierwave/test/matchers'

describe ImpressionUploader do
  include CarrierWave::Test::Matchers

  let(:user) { FactoryGirl.create(:user) }
  let(:image_file) { Rails.root.join('spec', 'support', 'huge.jpg') }

  subject { ImpressionUploader.new(user, :avatar) }

  before do
    ImpressionUploader.enable_processing = true
    subject.store!(File.open(image_file))
  end

  after do
    ImpressionUploader.enable_processing = false
    subject.remove!
  end

  context 'the catalog version' do
    it 'should scale down a landscape image to be exactly 200 by 200 pixels' do
      expect(subject.catalog).to have_dimensions(200, 170)
    end
  end

  context 'the detail version' do
    it 'should scale down a landscape image to fit within 700 by 700 pixels' do
      expect(subject.detail).to be_no_larger_than(2880, 2880)
    end
  end

  context 'upon recreation' do
    it 'does not rename the images' do
      expect { subject.recreate_versions! }.to_not change { subject.catalog.current_path }
    end
  end
end
