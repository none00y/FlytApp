class ConnectionsService 
  attr_reader :connection

  def initialize ( connection_params, connection = nil )
    @connection_params = connection_params
    @connection = connection.present? ? connection : Connection.new(connection_params)
  end
  
  def update_connection
    @connection.calculate_distance_between_airfields
    @connection.update(@connection_params)
  end

  def create_connection
    @connection.calculate_distance_between_airfields
    @connection.save
  end

end