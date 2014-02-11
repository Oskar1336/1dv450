class CreateTagResourceTable < ActiveRecord::Migration
  def change
    create_table :tag_resource_tables do |t|
    	t.belongs_to :Resource
    	t.belongs_to :Tag
    end
  end
end
