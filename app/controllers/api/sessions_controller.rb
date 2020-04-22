class Api::SessionsController < ApplicationController
  def create
    lat=params[:location][:latitude].to_f
    long=params[:location][:longitude].to_f
    results = Geocoder.search([lat, long])
    # edition = (results.first.city.match? /Stockholm|Gothenburg/) ? results.first.city : 'Country Wide'
    Event.near([lat, long], 50, units: :km)
    render json: {session: 
    {location:
    {latitude: lat,
    longitude: long},
    edition: edition }
  }
  end
end
