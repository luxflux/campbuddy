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

    if @attendance.save
      redirect_to @attendance, notice: 'Attendance was successfully created.'
    else
      render action: 'new'
    end
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
    redirect_to attendances_url, notice: 'Attendance was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def attendance_params
      params.require(:attendance).permit(:user_id, :workshop_id)
    end
end
