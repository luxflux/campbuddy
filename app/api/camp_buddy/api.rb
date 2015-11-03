module CampBuddy
  class API < Grape::API
    version 'v1', using: :header, vendor: 'camp-buddy'
    format :json
    use ::WineBouncer::OAuth2
    prefix 'api'

    resource :ping do
      desc 'Return a pong'
      oauth2 'read'
      get do
        { pong: Time.zone.now.iso8601 }
      end
    end
  end
end
