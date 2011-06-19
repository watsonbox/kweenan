class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name, :null => false
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :postcode, :null => false
      t.string :phone
      t.string :hours
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end