class Feature < ActiveRecord::Base

  ###################################
  # AR Plugins/gems
  ###################################
  acts_as_geographic
    
  #ActsAsTaggableOn
  acts_as_taggable
  
  #ThinkingSphinx
  define_index do
    #fields
    indexes :name
    indexes description
    #indexes tags
    
  end
  
  ###################################
  # Getters / Setters
  ###################################
  
  ###################################
  # Associations
  ###################################      
  has_and_belongs_to_many :open_spaces
  has_and_belongs_to_many :regions
  
  ###################################
  # Validations
  ###################################  
  
  ###################################
  # Callbacks
  ################################### 
  
  ##################################
  # instance methods
  ##################################

  ##################################
  # Class Methods
  ##################################
  
end
