module CampBuddy
  class API < Grape::API
    version 'v1', using: :accept_version_header, strict: true
    format :json
    use ::WineBouncer::OAuth2

    resource :ping do
      desc 'Return a pong'
      get do
        { pong: Time.zone.now.iso8601, user_id: resource_owner.id }
      end
    end

    mount CampBuddy::Events
    mount CampBuddy::Users
  end
end
