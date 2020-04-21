class Api::SessionsController < ApplicationController
  def create
    lat=params[:location][:latitude].to_f
    long=params[:location][:longitude].to_f
    results = Geocoder.search([lat, long])

    render json: {session: 
    {location:
    {latitude: lat,
    longitude: long},
    edition: results.first.city }
  }
  end
end
