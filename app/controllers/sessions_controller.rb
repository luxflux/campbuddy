class SessionsController < Clearance::SessionsController
  skip_before_action :require_login, only: :start_guest

  def new
    if signed_in?
      redirect_to root_url
    else
      super
    end
  end

  def start_guest
    sign_in User.create!(guest: true)
    redirect_to catalog_events_path
  end
end
