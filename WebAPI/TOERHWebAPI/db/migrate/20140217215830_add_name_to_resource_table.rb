class AddNameToResourceTable < ActiveRecord::Migration
  def change
  	change_table :resources do |t|
  		t.string :name, :limit => "100"
  	end
  end
end
