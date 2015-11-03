module CampBuddy
  class Users < Grape::API
    resource :users do
      route_param :id do
        desc 'Fetch the profile of a specific user'
        get do
          present User.find(params[:id]), with: CampBuddy::Entities::User
        end

        desc 'Fetch the events of a user'
        paginate
        get :events do
          events = User.find(params[:id]).events
          present paginate(events), with: CampBuddy::Entities::Event
        end
      end
    end
  end
end
