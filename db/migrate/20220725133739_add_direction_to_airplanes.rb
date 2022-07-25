class AddDirectionToAirplanes < ActiveRecord::Migration[6.0]
  def change
    add_column :airplanes, :direction, :boolean
  end
end
