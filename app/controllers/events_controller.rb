class EventsController < ApplicationController
  def index
    collection_events = Event.all
    if collection_events.empty?
      render json: { message: 'No events present' }, status: 404
    else
      render json: {events: collection_events}, status: 200
   end
  end

  def create
    event = Event.create(event_params)

    if event.persisted?
      render json: { message: 'Event was successfully created!' }, status: 200
    else
      render json: { message: 'Event was NOT created.' }, status: 422
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :category)
  end
end
