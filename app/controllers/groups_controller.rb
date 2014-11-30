class GroupsController < ApplicationController
  load_and_authorize_resource

  # GET /groups
  def index
    @groups = current_user.groups
    @leading = Group.where(leader_id:current_user.id)
  end
end
