require 'rails_helper'
require 'carrierwave/test/matchers'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { FactoryBot.create(:user) }
  let(:image_file) { Rails.root.join('spec', 'support', 'huge.jpg') }

  subject { AvatarUploader.new(user, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    subject.store!(File.open(image_file))
  end

  after do
    AvatarUploader.enable_processing = false
    subject.remove!
  end

  context 'the thumb version' do
    it 'should scale down a landscape image to be exactly 200 by 200 pixels' do
      expect(subject.thumb).to have_dimensions(200, 200)
    end
  end

  context 'the small version' do
    it 'should scale down a landscape image to fit within 700 by 700 pixels' do
      expect(subject.small).to be_no_larger_than(700, 700)
    end
  end

  context 'upon recreation' do
    it 'does not rename the images' do
      expect { subject.recreate_versions! }.to_not change { subject.thumb.current_path }
    end
  end
end
