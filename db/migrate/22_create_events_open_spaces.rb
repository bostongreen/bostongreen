class CreateEventsOpenSpaces < ActiveRecord::Migration
  def self.up
    create_table :events_open_spaces, :id=> false  do |t|
      t.integer :event_id
      t.integer :open_space_id
    end
    
    add_index :events_open_spaces, [:event_id, :open_space_id], :unique => true    
  end

  def self.down
    drop_table :events_open_spaces
  end
end
