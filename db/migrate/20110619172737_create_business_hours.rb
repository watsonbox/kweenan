class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.integer :merchant_id, :null => false
      t.integer :day, :null => false
      t.integer :start_time
      t.integer :end_time
      t.integer :start_time2
      t.integer :end_time2
      t.timestamps
    end
  end
end