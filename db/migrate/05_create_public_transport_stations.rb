class CreatePublicTransportStations < ActiveRecord::Migration
  def self.up
    create_table :public_transport_stations do |t|
      t.integer :open_space_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :public_transport_stations
  end
end
