class AddDirectionsToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :directions, :text
  end

  def self.down
    remove_column :features, :directions
  end
end
