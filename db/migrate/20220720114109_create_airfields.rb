class CreateAirfields < ActiveRecord::Migration[6.0]
  def change
    create_table :airfields do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :airfield_plane_capacity
    end
  end
end
