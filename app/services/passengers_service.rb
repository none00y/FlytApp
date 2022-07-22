class PassengersService
  attr_reader :passenger

  def initialize(passenger_params, passenger = nil)
    @passenger_params = passenger_params
    @passenger = passenger.present? ? passenger : Passenger.new(passenger_params)
  end

  def update_passenger
    @passenger.update(@passenger_params)
  end

  def create_passenger
    @passenger.save
  end

end
