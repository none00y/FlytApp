class Airplane < ApplicationRecord
  belongs_to :connection, optional: true
  has_many :passengers, dependent: :destroy

  validates_presence_of :identifier
  validates_presence_of :flight_speed
  validates_presence_of :passenger_capacity

  validate :passenger_capacity_is_positive_number
  validate :flight_speed_is_positive_number
  validate :identifier_has_proper_format
  validate :connection_not_full

  def connection_not_full
    return if connection.nil? || connection.can_add_airplane(self)

    errors.add(:connection, I18n.t('.connection_full'))
  end

  def passenger_capacity_is_positive_number
    return if passenger_capacity.positive?

    errors.add(:passenger_capacity, I18n.t('.number_must_be_positive'))
  end

  def flight_speed_is_positive_number
    return if flight_speed.positive?

    errors.add(:flight_speed, I18n.t('.number_must_be_positive'))
  end

  def identifier_has_proper_format
    return if identifier.blank? || identifier.match(/^[A-Z]-[A-Z]{4}|[A-Z,0-9]{1,3}-[A-Z]{3}|N[0-9]{1,5}[A-Z]{0,2}$/)

    errors.add(:identifier, I18n.t('.it_is_not_even_faked_well'))
  end

  enum state: {
    awaiting: 0,
    boarding: 1,
    unboarding: 3,
    flying: 2
  }

  STATES = states.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_states
    STATES
  end

  def self.get_human_states
    STATES.to_h { |k, _v| [Airplane.human_enum_name(:states, k), k] }
  end

  enum departure_day: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  DEPARTURE_DAYS = departure_days.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_departure_days
    DEPARTURE_DAYS
  end

  def self.get_human_departure_days
    DEPARTURE_DAYS.to_h { |k, _v| [Airplane.human_enum_name(:departure_days, k), k] }
  end

  def get_percentage_of_distance_travelled
    percentage_of_distance_travelled.floor(2)
  end

  def get_proper_departure_time
    departure_time.strftime('%R %Z')
  end

  def passenger_count
    passengers.size
  end

  def estimated_time_of_travel
    (connection.distance / flight_speed).hours
  end

  def departure_date
    time = if state == Airplane.get_states[:flying]
      Time.now.utc.beginning_of_week(departure_day.to_sym)
    else
      Time.now.utc.end_of_week(departure_day.to_sym)
    end
    time + departure_time.seconds_since_midnight
  end

  def future_departure_date
    Time.now.utc.end_of_week(departure_day.to_sym) + departure_time.seconds_since_midnight
  end

  def departure_count_until(datetime)
    ((future_departure_date.to_date - datetime.to_date) / 7.0).ceil
  end

  def estimated_arrival_time
    departure_date + estimated_time_of_travel
  end
end
