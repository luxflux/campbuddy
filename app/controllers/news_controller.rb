class NewsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships
  def index
    @news = @news.visible
    @emergency_numbers = EmergencyNumber.all
    @maps = Map.all
  end

  def emergency
  end
end
