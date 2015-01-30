class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  def show
    @events = @user.events.in_future

    last_modified = [@user.events.maximum(:updated_at), @user.updated_at].compact.max

    fresh_when last_modified: last_modified
  end

  # GET /users/1/edit
  def edit
    fresh_when @user
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
