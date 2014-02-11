class CreateLicences < ActiveRecord::Migration
  def change
    create_table :licences do |t|
    	t.string :licence_type, :null => false, :limit => "40"
      t.timestamps
    end
  end
end
