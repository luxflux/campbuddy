class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  def show
    @events = @user.events.in_future
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
