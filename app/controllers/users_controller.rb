class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  def show
    #@events = @user.events.in_future
    @events = @user.events.in_future.without_group_events
=begin
    #filter out gruop events where you don't take part
    @events.each do |event|
      if (event.groups_only == true)
        event.groups.each do |group|
          if (group.leader == current_user) || (group.users.where(email: current_user.email))
            delete(event)
          end
        end
      end
    end
=end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :firstname, :email, :password, :avatar)
    end
end
