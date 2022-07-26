class AddReturningFlagToAirplanes < ActiveRecord::Migration[6.0]
  def change
    add_column :airplanes, :returning, :boolean
  end
end
