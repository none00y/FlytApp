class AirplanesService
  attr_reader :airplane

  def initialize(airplane_params, airplane = nil)
    @airplane_params = airplane_params
    @airplane = airplane.present? ? airplane : Airplane.new(airplane_params)
  end

  def update_airplane
    @airplane.update(@airplane_params)
  end

  def create_airplane
    @airplane.save
  end

end
