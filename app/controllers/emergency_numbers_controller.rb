class EmergencyNumbersController < ApplicationController
  load_and_authorize_resource :news

  def index
    @emergency_numbers = EmergencyNumber.all
  end
end
