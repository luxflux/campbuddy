module CampBuddy
  module Entities
    class User < CampBuddy::Entities::Base
      expose :id
      expose :name, :firstname
      expose :email, :birthday, :cellphone
      expose :avatar do
        with_options(format_with: :image_url) do
          expose :avatar_thumb, as: :thumb
        end
      end

      def avatar_thumb
        object.avatar.thumb.url
      end
    end
  end
end
