class UsersController < ApplicationController
  load_and_authorize_resource except: %i(new create)
  skip_before_filter :require_login, only: [:create, :new]
  skip_before_filter :authorize, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or main_app.root_url
    else
      render :new
    end
  end

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

  def user_params
    params.require(:user).permit(:name, :firstname, :email, :password, :avatar)
  end
end
