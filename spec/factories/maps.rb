FactoryBot.define do
  factory :map do
    name 'S ganze Areal'
    description 'ganz une isch de iigang'
    map { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'map.jpg')) }
    order 1
  end
end
