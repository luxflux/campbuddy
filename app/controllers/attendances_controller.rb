class AttendancesController < ApplicationController
  load_and_authorize_resource

  # GET /attendances
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  def create
    @attendance = Attendance.new(attendance_params)

    @attendance.save!
    render text: nil, status: 201
  end

  # GET /attendances/remove
  def remove
    @user = User.where(id: attendance_params.user_id)
    @event = Event.where(id: attendance_params.event_id)
    @attendance = Attendance.where(user: @user, event: @event)
    @attendance.destroy    
  end

  # PATCH/PUT /attendances/1
  def update
    if @attendance.update(attendance_params)
      redirect_to @attendance, notice: 'Attendance was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /attendances/1
  def destroy
    @attendance.destroy
    render text: nil, status: 201
  end

  private
    # Only allow a trusted parameter "white list" through.
    def attendance_params
      params.require(:attendance).permit(:user_id, :event_id)
    end
end
