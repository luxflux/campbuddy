class SessionsController < Clearance::SessionsController
  skip_before_action :authorize, only: :start_guest

  def start_guest
    sign_in User.create!(guest: true)
    redirect_to catalog_events_path
  end
end
