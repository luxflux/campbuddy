class GroupsController < ApplicationController
  load_and_authorize_resource

  # GET /groups
  def index
    @groups = current_user.all_groups.includes(:users, :events, :leader)
  end
end
