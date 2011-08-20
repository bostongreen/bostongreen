class AddNameIndexToNeighborhoods < ActiveRecord::Migration
  def self.up
    add_index :open_spaces, :name
    add_index :features, :name
  end

  def self.down
    remove_index :regions, :name
    remove_index :open_spaces, :name    
    remove_index :features, :name
  end
end
