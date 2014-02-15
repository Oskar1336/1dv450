class AlterUserTable < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :username, :limit => "30"
  		t.string :password, :limit => "20"
  	end
  end
end
