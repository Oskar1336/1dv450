class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.string :tag, :null => false, :limit => "20"
      t.timestamps
    end
  end
end
