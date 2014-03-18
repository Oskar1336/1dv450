class RemoveLastnameFromUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.remove :lastname
  	end
  end
end
