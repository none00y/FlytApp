class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :state
      t.belongs_to :airplane
    end
  end
end
