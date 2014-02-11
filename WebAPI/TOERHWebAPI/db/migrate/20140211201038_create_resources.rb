class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
    	t.belongs_to :ResourceType
    	t.belongs_to :User
    	t.belongs_to :Licence
      t.timestamps
    end
  end
end
