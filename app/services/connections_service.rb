class ConnectionsService 
  attr_reader :connection

  def initialize ( connection_params, connection = nil )
    @connection_params = connection_params
    @connection = connection.present? ? connection : Connection.new(connection_params)
  end
  
  def update_connection
    @connection.update(@connection_params)
  end

  def create_connection
    @connection.save
  end

end