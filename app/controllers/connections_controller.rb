class ConnectionsController < ApplicationController
  def index
    @connections = Connection.all 
  end
  
  def show
    
  end

  def new
    byebug
    @connection = Connection.new
  end

  def create
    connection_service = ConnectionsService.new(connection_params)
    @connection = connection_service.connection
    if connection_service.create_connection
      redirect_to connections_path
    else
      respond_to do |format|
        format.js { render "connections/connection_management.js.erb", layout: false, locals: { action: "new"} }
      end
    end
  end

  def edit
    @connection = Connection.find(params[:id])
  end
  
  def update
    @connection = Connection.find(params[:id])
    connection_service = ConnectionsService.new(connection_params,@connection)
    if connection_service.update_connection
      redirect_to connections_path
    else
      respond_to do |format|
        format.js { render "connections/connection_management.js.erb", layout: false, locals: { action: "edit" } }
      end
    end
  end
  
  def destroy
    connection = Connection.find(params[:id])
    connection.destroy
    redirect_to connections_path
  end
  
  def connection_params
    params.require(:connection).permit(:airfield_a_id,:airfield_b_id)
  end

end