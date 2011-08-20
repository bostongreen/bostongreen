class AddLocationCategoryToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :location, :point, :srid => 4326
    add_column :features, :category, :string
  end

  def self.down
    remove_column :features, :category
    remove_column :features, :location
  end
end
