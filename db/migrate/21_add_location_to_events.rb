class AddLocationToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :location, :point, :srid => 4326
    
    add_index :events, :location, :spatial => true
  end
  
  def self.down
    remove_column :events, :location
  end
end
