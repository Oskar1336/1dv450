class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
    	t.string "contact_mail", :null => false
    	t.string "applicationname", :null => false
      t.timestamps
    end
  end
end
