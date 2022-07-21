class AirplanesController < ApplicationController
  def index
    @airplanes = Airplane.all 
  end
  
  def show

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
        format.js { render "airplanes/airplane_management.js.erb", layout: false, locals: { action: "new"} }
      end
    end
  end

  def edit
    byebug
    @airplane = Airplane.find(params[:id])
  end
  
  def update
    byebug
    @airplane = Airplane.find(params[:id])
    airplane_service = AirplanesService.new(airplane_params,@airplane)
    if airplane_service.update_airplane
      redirect_to airplanes_path
    else
      respond_to do |format|
        format.js { render "airplanes/airplane_management.js.erb", layout: false, locals: { action: "edit" } }
      end
    end
  end
  
  def destroy
    airplane = Airplane.find(params[:id])
    airplane.destroy
    redirect_to airplanes_path
  end
  
  def airplane_params
    byebug
    params.require(:airplane).permit()
  end

end