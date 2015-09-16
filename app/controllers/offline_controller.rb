class OfflineController < ApplicationController
  load_and_authorize_resource :user
  layout false

  def show
    @events = current_user.events.in_future
    @emergency_numbers = EmergencyNumber.all
  end
end
