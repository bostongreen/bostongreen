class AddIndicesToGeoSpatialModels < ActiveRecord::Migration
  def self.up
    add_index :open_spaces, :location, :spatial => true
    add_index :features, :location, :spatial => true
  end

  def self.down
    #remove_index :neigborhoods, :location, :spatial => true
    #remove_index :open_spaces, :location
    #remove_index :features, :location
  end
end
