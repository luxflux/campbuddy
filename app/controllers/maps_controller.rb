class MapsController < ApplicationController
  load_and_authorize_resource :news
  load_and_authorize_resource :map

  def index
  end
end
