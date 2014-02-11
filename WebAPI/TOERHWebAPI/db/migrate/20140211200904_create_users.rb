class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :firstname, :null => false, :limit => "40"
    	t.string :lastname, :null => false, :limit => "50"
    	t.string :email, :null => false, :limit => "40"
      t.timestamps
    end
  end
end
