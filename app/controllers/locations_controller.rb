class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @locations = Location.includes(:appointments)
    @total_appointments = Locations::LocationStatisticsService.total_per_location
    @unique_clients = Locations::LocationStatisticsService.unique_clients_per_location
  end

  def show; end

  def new
    @location = Location.new
    @location.addresses.build
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, notice: "Location was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @location.update(location_params)
      redirect_to @location, notice: "Location was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: "Location was successfully destroyed."
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(
      :name, :address,
      addresses_attributes: [ :id, :street, :city, :state, :zip_code, :country, :primary, :_destroy ],
    )
  end
end
