class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
    	t.integer :resource_type_id, :null => false
    	t.integer :user_id, :null => false
    	t.integer :licence_id, :null => false
    	t.string :description, :null => false
    	t.string :url, :null => false
      t.timestamps
    end
  end
end
