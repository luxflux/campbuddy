class NewsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships
  def index
    @news = @news.visible
    @emergency_numbers = EmergencyNumber.all
    @maps = Map.all
    @pics_of_the_day = PicOfTheDay.order(created_at: :desc).limit(18)
  end

  def emergency
  end
end
