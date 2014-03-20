class RemoveUnecessaryColumns < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.remove :email, :name
  	end
  end
end
