class CreateOpenSpacesRegions < ActiveRecord::Migration
  def self.up
    create_table :open_spaces_regions, :id=> false  do |t|
      t.integer :region_id
      t.integer :open_space_id
    end
    
    add_index :open_spaces_regions, [:open_space_id, :region_id], :unique => true
  end

  def self.down
    drop_table :open_spaces_regions
  end
end
