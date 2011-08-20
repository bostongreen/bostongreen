class FeatureTagging < ActiveRecord::Base
  belongs_to :feature
  belongs_to :category
end
