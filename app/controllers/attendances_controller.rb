class AttendancesController < ApplicationController
  load_and_authorize_resource

  # GET /attendances/1
  def show
    render json: @attendance
  end

  # POST /attendances
  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.save!
    render json: @attendance, status: 200
  rescue ActiveRecord::RecordInvalid
    render json: @attendance.errors, status: 422
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
