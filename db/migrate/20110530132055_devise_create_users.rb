class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :type, :null => false
      t.integer :merchant_id
      
      # Devise columns
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
  end
end