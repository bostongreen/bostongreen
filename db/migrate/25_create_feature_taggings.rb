class CreateFeatureTaggings < ActiveRecord::Migration
  def self.up
    create_table :feature_taggings do |t|
      t.integer :feature_id
      t.integer :category_id

      t.timestamps
    end
    
    add_index :feature_taggings, [:category_id, :feature_id], :unique => true    
  end

  def self.down
    drop_table :feature_taggings
  end
end
