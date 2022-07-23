class CreateAirplanes < ActiveRecord::Migration[6.0]
  def change
    create_table :airplanes do |t|
      t.string :identifier
      t.integer :state
      t.float :flight_speed
      t.integer :departure_day
      t.time :departure_time
      t.float :percentage_of_distance_travelled
      t.integer :passenger_capacity
      t.belongs_to :connection
    end
  end
end
