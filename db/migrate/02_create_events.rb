class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :open_space_id
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
