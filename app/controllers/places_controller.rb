class PlacesController < AuthenticatedController
  def show
    @place = Place.find(params[:id])
  end
end
