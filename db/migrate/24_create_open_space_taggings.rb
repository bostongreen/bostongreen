class CreateOpenSpaceTaggings < ActiveRecord::Migration
  def self.up
    create_table :open_space_taggings do |t|
      t.integer :open_space_id
      t.integer :category_id

      t.timestamps
    end
    
    add_index :open_space_taggings, [:category_id, :open_space_id], :unique => true
  end

  def self.down
    drop_table :open_space_taggings
  end
end
