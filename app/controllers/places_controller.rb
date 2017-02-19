require 'beermapping_api'

class PlacesController < ApplicationController
  def index
  end

  def show
    @bar = BeermappingApi.get_bar_by_id_and_city(session[:last_search], params[:id])
  end

  def search
    @places = BeermappingApi.places_in(params[:city])

    session[:last_search] = params[:city]

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end