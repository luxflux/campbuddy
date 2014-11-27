class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  def show
    @owned_events = @user.owned_events.in_future
    @events = @user.events.in_future - @owned_events
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

  # POST /users/import
  def import
    if params[:file]
      User.import(params[:file])
    end

    redirect_to users_path, notice: "Products imported."
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :firstname, :email, :password, :avatar)
    end
end
