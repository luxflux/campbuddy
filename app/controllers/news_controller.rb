class NewsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships
  def index
    @news = @news.visible

    fresh_when last_modified: @news.maximum(:updated_at)
  end

  def emergency
  end
end
