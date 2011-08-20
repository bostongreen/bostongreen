class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :name
      t.multi_polygon :location, :srid => 4326
      t.timestamps
    end
    
    add_index :regions, :name
    add_index :regions, :location, :spatial => true
  end

  def self.down
    drop_table :regions
  end
end
