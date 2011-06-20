class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.integer :merchant_id, :null => false
      t.integer :day, :null => false
      t.integer :start_time
      t.integer :end_time
      t.integer :break_start_time
      t.integer :break_end_time
      t.timestamps
    end
  end
end