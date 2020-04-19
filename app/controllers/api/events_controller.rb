class Api::EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]

  def index
    collection_events = Event.all
    if collection_events.empty?
      render json: { message: 'No events present' }, status: 404
    else
      render json: {events: collection_events}, status: 200
   end
  end

  def create
    event = current_user.events.create(event_params)
    if event.persisted?
      render json: { message: 'Event was successfully created!' }, status: 200
    else
      render json: { message: 'Event was NOT created.' }, status: 422
    end
  end

  def update
    event = Event.find(id: params[:id])
    if event.attendee_limit >= event.attendees.count + 1
      event.attendees.create(user: current_user)
      render json: {message: 'You are on the guest list!'}
    else 
      render json: { error_message: 'Guest list is full...' }, status: 400
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :category)
  end
end