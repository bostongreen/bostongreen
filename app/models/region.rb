class Region < ActiveRecord::Base
  
  
  ###################################
  # AR Plugins/gems
  ###################################
  acts_as_geographic
  
  ###################################
  # Getters / Setters
  ###################################
  
  ###################################
  # Associations
  ###################################
  has_and_belongs_to_many :open_spaces
  has_and_belongs_to_many :features
  
  ###################################
  # Validations
  ###################################
  
  ###################################
  # Callbacks
  ###################################
  
  ###################################
  # instance methods
  ###################################

  ##################################
  # Class Methods
  ##################################
  
  scope :ordered_by_name, includes(:open_spaces).order("name ASC")
  scope :only_id_and_name, select("id,name").order("name ASC")
  scope :by_id, lambda { |id| where(:id => id)}
end
