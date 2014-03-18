class AddOmniauthFields < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string "provider"
  		t.string "uid"
  		t.string "name"
  		t.string "token"
  		t.string "auth_token"
  		t.datetime "token_expires"
  	end
  end
end
