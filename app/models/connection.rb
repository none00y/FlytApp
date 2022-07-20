class Connection < ApplicationRecord

  validates_presence_of :airfield_a_id
  validates_presence_of :airfield_b_id
  validates_presence_of :distance

  validate :airfield_a_id_exists
  validate :airfield_b_id_exists
  validate :distance_is_positive
  validate :airfields_are_uniqe

  def airfield_a_id_exists
    return if Airfield.find(airfield_a_id)
    errors.add(:airfield_a_id,"Choose and exisiting airfield")
  end

  def airfield_b_id_exists
    return if Airfield.find(airfield_b_id)
    errors.add(:airfield_b_id,"Choose and exisiting airfield")
  end

  def airfields_are_uniqe
    return if airfield_a_id != airfield_b_id
    errors.add(:airfield_a_id, "Airfields can't be the same")
    errors.add(:airfield_b_id, "Airfields can't be the same")
  end

  def distance_is_positive
    return if distance.positive?
    errors.add(:distance, "Distance can't be negative")
  end

  def get_distance_between_airfields
    airfield1 = Airfield.find(airfield_a_id)
    airfield2 = Airfield.find(airfield_b_id)
    distance = GeoHelper.get_distance_on_earths_surface(airfield1.latitude, airfield1.longitude,
                                                        airfield2.latitude, airfield2.longitude)
  end
end