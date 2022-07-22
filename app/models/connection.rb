class Connection < ApplicationRecord
  belongs_to :airfield_a, optional: false, class_name: 'Airfield', foreign_key: :airfield_a_id
  belongs_to :airfield_b, optional: false, class_name: 'Airfield', foreign_key: :airfield_b_id
  has_many :airplanes, dependent: :destroy

  validates_presence_of :airfield_a_id
  validates_presence_of :airfield_b_id
  validates_presence_of :distance

  validate :airfield_a_id_exists
  validate :airfield_b_id_exists
  validate :airfields_are_uniqe
  validate :connection_is_unique

  def connection_is_unique
    return if Connection.all.where(airfield_a_id: airfield_a_id).find_by(airfield_b_id: airfield_b_id).nil?

    errors.add(:airfield_a_id, 'Connection already exists!')
    errors.add(:airfield_b_id, 'Connection already exists!')
  end

  def airfield_a_id_exists
    return unless Airfield.find(airfield_a_id).nil?

    errors.add(:airfield_a_id, 'Choose an exisiting airfield')
  end

  def airfield_b_id_exists
    return unless Airfield.find(airfield_b_id).nil?

    errors.add(:airfield_b_id, 'Choose an exisiting airfield')
  end

  def airfields_are_uniqe
    return if airfield_a_id != airfield_b_id

    errors.add(:airfield_a_id, "Airfields can't be the same")
    errors.add(:airfield_b_id, "Airfields can't be the same")
  end

  def calculate_distance_between_airfields
    airfield_a = Airfield.find(airfield_a_id)
    airfield_b = Airfield.find(airfield_b_id)
    self.distance = GeoHelper.get_distance_on_earths_surface(
      airfield_a.latitude, airfield_a.longitude,
      airfield_b.latitude, airfield_b.longitude
)
  end

  def description
    I18n.t('.connection_path',
           origin: Airfield.find(airfield_a_id).name,
           destination: Airfield.find(airfield_b_id).name)
  end
end
