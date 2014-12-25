class RootController < ApplicationController
  def show
    if current_user.guest?
      redirect_to catalog_events_path
    else
      redirect_to news_index_path
    end
  end
end
