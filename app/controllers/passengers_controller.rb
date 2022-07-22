class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find(params[:id])
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger_service = PassengersService.new(passenger_params)
    @passenger = passenger_service.passenger
    if passenger_service.create_passenger
      redirect_to passengers_path
    else
      respond_to do |format|
        format.js { render 'passengers/passenger_management.js.erb', layout: false, locals: { action: 'new'} }
      end
    end
  end

  def edit
    @passenger = Passenger.find(params[:id])
  end

  def update
    @passenger = Passenger.find(params[:id])
    passenger_service = PassengersService.new(passenger_params, @passenger)
    if passenger_service.update_passenger
      redirect_to passengers_path
    else
      respond_to do |format|
        format.js { render 'passengers/passenger_management.js.erb', layout: false, locals: { action: 'edit' } }
      end
    end
  end

  def destroy
    passenger = Passenger.find(params[:id])
    passenger.destroy
    redirect_to passengers_path
  end

  def passenger_params
    params.require(:passenger).permit(:first_name, :last_name)
  end

end
