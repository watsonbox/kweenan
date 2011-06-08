class CreateBusinessCategories < ActiveRecord::Migration
  def change
    create_table :business_categories do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    add_column :merchants, :business_category_id, :integer, :null => false
  end
end