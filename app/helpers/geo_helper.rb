module GeoHelper
  EARTH_RADIUS = 6371.137

  def self.get_distance_on_earths_surface(latitude1,longitude1,latitude2,longitude2)
    lat1_rad = deg_to_rad(latitude1)
    lat2_rad = deg_to_rad(latitude2)
    lat_delta =  deg_to_rad(latitude2 - latitude1)
    lon_delta = deg_to_rad(longitude2 - longitude1)

    a = Math.sin(lat_delta/2) ** 2 +
        Math.cos(lat1_rad) * Math.cos(lat2_rad) *
        Math.sin(lon_delta/2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a),Math.sqrt(1-a))

    #distance in km
    distance = EARTH_RADIUS * c
  end
  
  def self.deg_to_rad(degrees)
    radians = degrees * Math::PI / 180
  end
end