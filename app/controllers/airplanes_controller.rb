class AirplanesController < ApplicationController
  def index
    @airplanes = Airplane.all.order(:identifier)
  end

  def show
    @airplane = Airplane.find(params[:id])
  end

  def new
    @airplane = Airplane.new
  end

  def create
    airplane_service = AirplanesService.new(airplane_params)
    @airplane = airplane_service.airplane
    if airplane_service.create_airplane
      redirect_to airplanes_path
    else
      respond_to do |format|
        format.js { render 'airplanes/airplane_management.js.erb', layout: false, locals: { action: 'new'} }
      end
    end
  end

  def edit
    @airplane = Airplane.find(params[:id])
  end

  def update
    @airplane = Airplane.find(params[:id])
    airplane_service = AirplanesService.new(airplane_params, @airplane)
    if airplane_service.update_airplane
      redirect_to airplanes_path
    else
      respond_to do |format|
        format.js { render 'airplanes/airplane_management.js.erb', layout: false, locals: { action: 'edit' } }
      end
    end
  end

  def destroy
    airplane = Airplane.find(params[:id])
    airplane.destroy
    redirect_to airplanes_path
  end

  def airplane_params
    params.require(:airplane).permit(:connection_id, :passenger_capacity, :identifier, :flight_speed, :departure_day, :departure_time, :percentage_of_distance_travelled, :state)
  end

end
