module CampBuddy
  class Events < Grape::API
    resource :events do
      desc 'Get all events'
      paginate
      get do
        events = Event.order(:starts).includes(:category)
        present paginate(events), with: CampBuddy::Entities::Event
      end

      route_param :id do
        desc 'Get the users who attend an event'
        paginate
        get :users do
          users = Event.find(params[:id]).users
          present paginate(users), with: CampBuddy::Entities::User
        end
      end
    end
  end
end
