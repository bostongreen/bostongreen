class CreateFeaturesRegions < ActiveRecord::Migration
  def self.up
    create_table :features_regions, :id=> false  do |t|
      t.integer :region_id
      t.integer :feature_id
    end
    
    add_index :features_regions, [:feature_id, :region_id], :unique => true
  end

  def self.down
    drop_table :features_regions
  end
end
