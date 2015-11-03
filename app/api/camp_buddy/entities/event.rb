module CampBuddy
  module Entities
    class Event < CampBuddy::Entities::Base
      expose :id
      expose :owner_id, as: :leader_id
      expose :title, :teaser, :description
      expose :meeting_point
      expose :youtube_url
      expose :max_attendees
      expose :attendance_places_left, as: :free_slots
      expose :groups_only, as: :group_event
      expose :mandatory?, as: :mandatory
      expose :info_only?, as: :info_event

      expose :category do |event|
        event.category.name
      end

      with_options(format_with: :iso_timestamp) do
        expose :starts
        expose :ends
      end

      expose :impression do
        with_options(format_with: :image_url) do
          expose :impression_catalog, as: :catalog
          expose :impression_detail, as: :detail
        end
      end

      def impression_catalog
        object.impression.catalog.url
      end

      def impression_detail
        object.impression.detail.url
      end
    end
  end
end
