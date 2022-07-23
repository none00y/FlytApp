class Airfield < ApplicationRecord
  has_many :outgoing_connections, class_name: 'Connection', foreign_key: :airfield_a_id, dependent: :destroy
  has_many :incoming_connections, class_name: 'Connection', foreign_key: :airfield_b_id, dependent: :destroy

  validates_presence_of :longitude
  validates_presence_of :latitude
  validates_presence_of :airfield_plane_capacity
  validates_presence_of :name

  validate :longitude_within_allowable_range
  validate :latitude_within_allowable_range
  validate :airfield_plane_capacity_is_positive

  def longitude_within_allowable_range
    return if longitude.between?(-180, 180)

    errors.add(:longitude, 'Outside of allowde range!')
  end

  def latitude_within_allowable_range
    return if latitude.between?(-90, 90)

    errors.add(:latitude, 'Outside of allowed range!')
  end

  def airfield_plane_capacity_is_positive
    return if airfield_plane_capacity.positive?

    errors.add(:airfield_plane_capacity, 'Should be a positive number!')
  end
end
