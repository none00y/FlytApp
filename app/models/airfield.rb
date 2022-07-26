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

    errors.add(:longitude,  I18n.t(".heading_into_10th_dimension"))
  end

  def latitude_within_allowable_range
    return if latitude.between?(-90, 90)

    errors.add(:latitude,  I18n.t(".heading_into_10th_dimension"))
  end

  def airfield_plane_capacity_is_positive
    return if airfield_plane_capacity.positive?

    errors.add(:airfield_plane_capacity,  I18n.t(".number_must_be_positive"))
  end

  def incoming_airplanes
    airplanes = []

    incoming_connections.each do |connection|
     airplanes = airplanes + connection.airplanes.where(returning: false)
    end

    outgoing_connections.each do |connection|
      airplanes = airplanes + connection.airplanes.where(returning: true)
    end

    airplanes
  end
  
  def outgoing_airplanes
    airplanes = []

    outgoing_connections.each do |connection|
      airplanes = airplanes + connection.airplanes.where(returning: false)
    end

    incoming_connections.each do |connection|
      airplanes = airplanes + connection.airplanes.where(returning: true)
    end

    airplanes
  end

  def self.normalize_datetime(datetime)

    if (datetime - Time.now).to_i < 0
      new_datetime = datetime + 14.days * 
      (1 - (datetime.to_date - Time.now.to_date).to_i/14)
    else
      new_datetime = datetime - ((datetime.to_date - Time.now.to_date).to_i/14).floor * 14.days
    end

    new_datetime
  end

  def airplanes_at_time(datetime)
    airplanes = []

    if 
      incoming_airplanes.each do |airplane|
        if airplane.estimated_arrival_time < datetime
          airplanes << airplane 
        end
      end
  
      outgoing_airplanes.each do |airplane|
        if airplane.departure_date > datetime
          airplanes << airplane 
        end
      end
    else
      incoming_airplanes.each do |airplane|
        if airplane.estimated_arrival_time > datetime
          airplanes << airplane 
        end
      end
  
      outgoing_airplanes.each do |airplane|
        if airplane.departure_date < datetime
          airplanes << airplane 
        end
      end
    end

    airplanes
  end

  def can_add_airplane
    byebug
    incoming_airplanes.order_by(:departure_date)
  end
end
