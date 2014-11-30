class NewsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships
  def index
    @news = @news.visible
  end
end
