class CreateFeaturesOpenSpacesTable < ActiveRecord::Migration
  def self.up
    create_table :features_open_spaces, :id=> false  do |t|
      t.integer :feature_id
      t.integer :open_space_id
    end
    
    add_index :features_open_spaces, [:feature_id, :open_space_id], :unique => true
  end

  def self.down
    drop_table :features_open_spaces
  end
end
