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

  def show
    event = Event.find(params[:id])
    render json: event, serializer: EventListSerializer, status: 200
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
    event = Event.where(id: params[:id]).first
    event.attendees.create(user: current_user)
    render json: { message: 'You are on the guest list!'}
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :category)
  end
end
