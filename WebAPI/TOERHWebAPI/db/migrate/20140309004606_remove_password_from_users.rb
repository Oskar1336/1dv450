class RemovePasswordFromUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.remove :password, :username
  	end
  end
end
