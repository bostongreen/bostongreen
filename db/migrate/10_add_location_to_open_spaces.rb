class AddLocationToOpenSpaces < ActiveRecord::Migration
  def self.up
    add_column :open_spaces, :location, :multi_polygon, :srid => 4326
    add_column :open_spaces, :ownership, :string
  end

  def self.down
    remove_column :open_spaces, :location
    remove_column :open_spaces, :ownership
  end
end
