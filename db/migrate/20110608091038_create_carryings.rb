class CreateCarryings < ActiveRecord::Migration
  def change
    create_table :carryings do |t|
      t.references :merchant, :null => false
      t.references :brand, :null => false
      t.timestamps
    end
  end
end