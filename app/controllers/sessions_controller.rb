class SessionsController < Clearance::SessionsController
  skip_before_action :authorize, only: :start_guest

  def start_guest
  end
end
