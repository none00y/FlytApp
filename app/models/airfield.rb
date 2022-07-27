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

    errors.add(:longitude, I18n.t('.heading_into_10th_dimension'))
  end

  def latitude_within_allowable_range
    return if latitude.between?(-90, 90)

    errors.add(:latitude, I18n.t('.heading_into_10th_dimension'))
  end

  def airfield_plane_capacity_is_positive
    return if airfield_plane_capacity.positive?

    errors.add(:airfield_plane_capacity, I18n.t('.number_must_be_positive'))
  end

  def incoming_airplanes
    airplanes = []

    incoming_connections.each do |connection|
      airplanes += connection.airplanes.where(returning: false)
    end

    outgoing_connections.each do |connection|
      airplanes += connection.airplanes.where(returning: true)
    end

    airplanes
  end

  def outgoing_airplanes
    airplanes = []

    outgoing_connections.each do |connection|
      airplanes += connection.airplanes.where(returning: false)
    end

    incoming_connections.each do |connection|
      airplanes += connection.airplanes.where(returning: true)
    end

    airplanes
  end

  def self.normalize_datetime(datetime)
    if datetime < Time.now
      self.normalize_datetime(datetime + 14.days * (1 + (Time.now.utc.to_date - datetime.to_date).to_i / 14.0).floor - (Time.now.utc.to_date - datetime.to_date)%14)
    else
      datetime - ((datetime.to_date - Time.now.to_date).to_i / 14).floor * 14.days
    end
  end

  def airplanes_at_time(datetime)
    airplanes = []
    datetime = Airfield.normalize_datetime(datetime)
    puts datetime
    if (datetime.to_date - Time.now.utc.to_date).to_i%14 < 7 
      incoming_airplanes.each do |airplane|
         airplanes << airplane if airplane.departure_date < datetime
       end

      outgoing_airplanes.each do |airplane|
        airplanes << airplane if airplane.departure_date > datetime
      end
    else
      incoming_airplanes.each do |airplane|
        airplanes << airplane if airplane.departure_date + 7.days> datetime
      end

      outgoing_airplanes.each do |airplane|
        airplanes << airplane if airplane.departure_date + 7.days< datetime
      end
    end

    airplanes
  end

  def can_add_airplane(airplane)
    if airplane.returning ==  false
      if airplane.connection.airfield_a == self
        return can_add_starting_airplane(airplane)
      else
        return can_add_landing_airplane(airplane)
      end
    else
      if airplane.connection.airfield_a == self
        can_add_landing_airplane(airplane)
      else
        can_add_starting_airplane(airplane)
      end
    end
  end

  def can_add_starting_airplane(airplane)
    airplanes_at_time(airplane.departure_date).size < airfield_plane_capacity &&
    airplanes_at_time(airplane.departure_date - 7.days).size < airfield_plane_capacity
  end

  def can_add_landing_airplane(airplane)
    airplanes_at_time(airplane.departure_date).size < airfield_plane_capacity &&
    airplanes_at_time(airplane.departure_date + 7.days).size < airfield_plane_capacity
  end
end
