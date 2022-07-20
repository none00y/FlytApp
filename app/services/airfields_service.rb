class AirfieldsService 
  attr_reader :airfield

  def initialize ( airfield_params, airfield = nil )
    @airfield_params = airfield_params
    @airfield = airfield.present? ? airfield : Airfield.new(airfield_params)
  end
  
  def update_airfield
    @airfield.update(@airfield_params)
  end

  def create_airfield
    @airfield.save
  end

end