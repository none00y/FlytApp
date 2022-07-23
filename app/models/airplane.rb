class Airplane < ApplicationRecord
  belongs_to :connection
  has_many :passengers, dependent: :destroy

  validates_presence_of :identifier
  validates_presence_of :flight_speed
  validates_presence_of :passenger_capacity

  validate :passenger_capacity_is_positive_number
  validate :flight_speed_is_positive_number
  validate :identifier_has_proper_format

  def passenger_capacity_is_positive_number
    return if passenger_capacity.positive?

    errors.add(:passenger_capacity, 'Must be greater than 0')
  end

  def flight_speed_is_positive_number
    return if flight_speed.positive?

    errors.add(:flight_speed, 'Must be greater than 0')
  end

  def identifier_has_proper_format
    return if identifier.blank? || identifier.match(/^[A-Z]-[A-Z]{4}|[A-Z,0-9]{1,3}-[A-Z]{3}|N[0-9]{1,5}[A-Z]{0,2}$/)

    errors.add(:identifier, "Doesn't match known international registration patterns")
  end

  enum state: {
    awaiting: 0,
    boarding: 1,
    unborading: 3,
    moving_to_destination: 2
  }

  STATES = states.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_states
    STATES
  end

  enum departure_day: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  DEPARTURE_DAYS = departure_days.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_departure_days
    DEPARTURE_DAYS
  end

  def get_percentage_of_distance_travelled
    distance_travelled = percentage_of_distance_travelled
    distance_travelled = 100 - distance_travelled if state == Airplane.get_states[:returning_to_origin]
    distance_travelled.floor(2)
  end

  def get_proper_departure_time
    departure_time.strftime('%R %Z')
  end

  def passenger_count
    passengers.size
  end
end
