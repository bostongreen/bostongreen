class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :rough_name
      t.string :display_name

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
