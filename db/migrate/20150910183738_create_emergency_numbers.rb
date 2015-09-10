class CreateEmergencyNumbers < ActiveRecord::Migration
  def change
    create_table :emergency_numbers do |t|
      t.string :name
      t.string :number
      t.integer :color
      t.integer :order

      t.timestamps null: false
    end
  end
end
