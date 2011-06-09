class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :merchant_id
      t.string :data_file_name, :string
      t.string :data_content_type, :string
      t.integer :data_file_size
      t.datetime :data_updated_at
      t.timestamps
    end
  end
end