class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
    	t.belongs_to :Application
    	t.string :key, :null => false, :limit => "40"
      t.timestamps
    end
  end
end
