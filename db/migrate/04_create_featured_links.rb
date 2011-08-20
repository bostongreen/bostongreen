class CreateFeaturedLinks < ActiveRecord::Migration
  def self.up
    create_table :featured_links do |t|
      t.integer :open_space_id
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :featured_links
  end
end
