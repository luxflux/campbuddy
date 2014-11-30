class EventsController < ApplicationController
  load_and_authorize_resource

  # GET /events
  def index
    begin
      @selected_date = Date.parse(params[:date].to_s)
    rescue ArgumentError
      @selected_date = Date.current
    end
    @events = Event.on_date(@selected_date).order(:starts)
    @categories = Category.where(id: @events.pluck(:category_id))
  end

  # GET /events/catalog
  def catalog
    @events = @events.in_future.except_mandatory.except_group_events
    @categories = Category.where(id: @events.pluck(:category_id))
  end

  # GET /events/1
  def show
  end

  # GET /events/1/edit
  def edit
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render action: 'edit'
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def event_params
      params.
        require(:event).
        permit :owner_id, :category_id,
               :starts_date, :starts_time,
               :ends_date, :ends_time,
               :title, :description, :meeting_point,
               :impression, :mandatory
    end
end
