class AirfieldsController < ApplicationController
  def index
    @airfields = Airfield.all.order(:name)
  end

  def show
    @airfield = Airfield.find(params[:id])
    @incoming_connections = @airfield.incoming_connections
    @outgoing_connections = @airfield.outgoing_connections
  end

  def new
    @airfield = Airfield.new
  end

  def create
    airfield_service = AirfieldsService.new(airfield_params)
    @airfield = airfield_service.airfield
    if airfield_service.create_airfield
      redirect_to airfields_path
    else
      respond_to do |format|
        format.js { render 'airfields/airfield_management.js.erb', layout: false, locals: { action: 'new'} }
      end
    end
  end

  def edit
    @airfield = Airfield.find(params[:id])
  end

  def update
    @airfield = Airfield.find(params[:id])
    airfield_service = AirfieldsService.new(airfield_params, @airfield)
    if airfield_service.update_airfield
      redirect_to airfields_path
    else
      respond_to do |format|
        format.js { render 'airfields/airfield_management.js.erb', layout: false, locals: { action: 'edit' } }
      end
    end
  end

  def destroy
    airfield = Airfield.find(params[:id])
    airfield.destroy
    redirect_to airfields_path
  end

  def airfield_params
    params.require(:airfield).permit(:latitude, :longitude, :name, :airfield_plane_capacity)
  end
end
