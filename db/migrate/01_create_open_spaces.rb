class CreateOpenSpaces < ActiveRecord::Migration
  def self.up
    create_table :open_spaces do |t|
      t.string :name
      t.text :description
      t.integer :dcr_park
      t.text :directions

      t.timestamps
    end
  end

  def self.down
    drop_table :open_spaces
  end
end
