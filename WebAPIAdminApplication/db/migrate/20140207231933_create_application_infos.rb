class CreateApplicationInfos < ActiveRecord::Migration
  def change
    create_table :application_infos do |t|
    	t.string :applicationname, :null => false, :limit => "50"
    	t.string :email, :null => false
    	t.string :apikey, :null => false, :limit => "40"
      t.timestamps
    end
  end
end
