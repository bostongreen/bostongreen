class RenameOpenSpaceIdOnEvents < ActiveRecord::Migration
  def self.up
    rename_column :events, :open_space_id, :boston_event_id
    add_column :events, :start_time, :string
    add_column :events, :end_time, :string
    change_column :events, :description, :text
  end

  def self.down
    rename_column :events, :boston_event_id, :open_space_id
    remove_column :events, :start_time
    remove_column :events, :end_time
    change_column :events, :description, :string
  end
end
