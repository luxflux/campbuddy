class GroupsController < ApplicationController
  load_and_authorize_resource

  # GET /groups
  def index
    @groups = current_user.leaded_groups | current_user.groups
  end
end
