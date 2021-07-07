class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
      create_table :vehicles do |t|
        t.string :model
        t.string :make
        t.integer :year
        t.integer :milage
        t.string :model_number
        t.references :owner, polymorphic: true
        t.timestamps
      end
  end

end
