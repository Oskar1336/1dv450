class RemoveFirstnameFromUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.remove :firstname
  	end
  end
end
