module CampBuddy
  module Entities
    class Base < Grape::Entity
      format_with(:iso_timestamp) { |time| time.iso8601 }
      format_with(:image_url) { |path| ActionController::Base.helpers.image_url path }
    end
  end
end
