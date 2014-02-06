class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
    	t.string "auth_token", :null => false
    	t.integer "application_id", :null => false
      t.timestamps
    end
  end
end
