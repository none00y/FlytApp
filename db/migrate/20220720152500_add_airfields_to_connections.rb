class AddAirfieldsToConnections < ActiveRecord::Migration[6.0]
  def change
    add_reference :connections, :airfield_a, foreign_key: { to_table: :airfields }, on_delete: :cascade
    add_reference :connections, :airfield_b, foreign_key: { to_table: :airfields }, on_delete: :cascade
  end
end
