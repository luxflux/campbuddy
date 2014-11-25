class GroupsController < ApplicationController
  load_and_authorize_resource

  # GET /groups
  def index
    @groups = Group.all
  end
end
