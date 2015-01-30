class EventsController < ApplicationController
  load_and_authorize_resource

  # GET /events
  def index
    begin
      @selected_date = Date.parse(params[:date].to_s)
    rescue ArgumentError
      @selected_date = Date.current
    end
    if @selected_date < Setting.camp_start
      @selected_date = Setting.camp_start
    end
    if @selected_date > Setting.camp_end
      @selected_date = Setting.camp_end
    end

    @events = Event.on_date(@selected_date).except_group_events.order(:starts)
    @categories = Category.where(id: @events.pluck(:category_id))

    fresh_when @events.maximum(:updated_at).to_s, last_modified: @events.maximum(:updated_at)
  end

  # GET /events/catalog
  def catalog
    @events = @events.in_future.except_mandatory.except_group_events
    @categories = Category.where(id: @events.pluck(:category_id))

    fresh_when @events.maximum(:updated_at)
  end

  # GET /events/1
  def show
    fresh_when [@event.cache_key, @event.attended_by_user?(current_user)].join
  end

  # GET /events/1/edit
  def edit
    fresh_when @event
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to event_path(@event, back: params[:back])
    else
      render action: 'edit'
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def event_params
      params.
        require(:event).
        permit :starts_date, :starts_time,
               :ends_date, :ends_time,
               :title,
               :teaser, :description,
               :meeting_point,
               :impression
    end
end
