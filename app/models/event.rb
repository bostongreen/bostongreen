class Event < ActiveRecord::Base
  
  ###################################
  # AR Plugins/gems
  ###################################
  
  has_attached_file :photo, :styles => {:thumb => "140x140#"}
  
  #Will Paginate
  cattr_reader :per_page
  @@per_page = 10  
  
  ###################################
  # Getters / Setters
  ###################################
  
  ###################################
  # Associations
  ###################################
  has_and_belongs_to_many :open_spaces
  
  ###################################
  # Validations
  ###################################
  
  ###################################
  # Callbacks
  ###################################
  
  ###################################
  # Scopes
  ###################################
  scope :with_open_spaces, joins(:open_spaces).order("start_time asc")
  
  ###################################
  # instance methods
  ###################################
  def timeify(time)
    Time.parse(self.send(time)).utc
  end
  
  ##################################
  # Class Methods
  ##################################
  def self.current
    where("start_time >= ?", Time.now.midnight)
  end
  
end
