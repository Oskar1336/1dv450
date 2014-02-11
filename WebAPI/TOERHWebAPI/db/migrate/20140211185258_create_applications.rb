class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
    	t.string :contact_mail, :null => false
    	t.string :application_name, :null => false, :limit => "50"
      t.timestamps
    end
  end
end
