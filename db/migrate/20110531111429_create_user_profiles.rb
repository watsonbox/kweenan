class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user, :null => false
      t.string :gender, :limit => 1
      t.date :date_of_birth
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :postcode
      
      t.timestamps
    end
  end
end