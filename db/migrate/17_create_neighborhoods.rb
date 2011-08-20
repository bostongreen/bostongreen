class CreateNeighborhoods < ActiveRecord::Migration
  def self.up
    create_table :neighborhoods do |t|
      t.string :name
      t.polygon :location, :srid => 4326
      t.timestamps
    end
    
    add_index :neighborhoods, :name
    add_index :neighborhoods, :location, :spatial => true
  end

  def self.down
    drop_table :neighborhoods
  end
end