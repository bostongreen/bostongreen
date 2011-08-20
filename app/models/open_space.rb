class OpenSpace < ActiveRecord::Base

  
  ###################################
  # AR Plugins/gems
  ###################################
  acts_as_geographic
  
  #ActsAsTaggableOn
  acts_as_taggable
  
  #Paperclip
  has_attached_file :photo, :styles => {:thumb => "80x80#"}
  
  #ThinkingSphinx
  define_index do
    #fields
    indexes :name
    indexes description
    #indexes tags
    
  end
  
  #Will Paginate
  cattr_reader :per_page
  @@per_page = 10
  
  ###################################
  # Getters / Setters
  ###################################
  
  ###################################
  # Associations
  ################################### 
  
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :features
  has_many :featured_links
  has_one :public_transport_station
  has_and_belongs_to_many :events
  
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
  
  scope :without_location, select("name,id,description,directions")
  scope :first_space_without_location, lambda { |id| without_location.where(:id => id).limit(1) }
  scope :only_id_and_name, select("open_spaces.id, open_spaces.name")
  scope :including_region, lambda { |region| joins(:regions) & Region.by_id(region)}
  scope :properly_ordered, order("description asc, name asc")
  scope :find_nearby_spaces, lambda { |lat,lng| 
    only_id_and_name.select_distance(lat,lng).ordered_by_distance(lat,lng)
  }  
  scope :within_neighborhood, lambda { |region| 
    only_id_and_name.including_region(region).properly_ordered
  }
  
end