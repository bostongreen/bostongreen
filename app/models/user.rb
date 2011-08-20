class User < ActiveRecord::Base
  
  ###################################
  # AR Plugins/gems
  ###################################

  #Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname, :login, :first_name, :last_name         
  
  ###################################
  # Getters / Setters
  ###################################
  
  attr_accessor :login
  
  ###################################
  # Associations
  ###################################      
  
  has_many :authentications  
  
  ###################################
  # Validations
  ###################################  
  
  ###################################
  # Callbacks
  ################################### 
  
  ##################################
  # instance methods
  ##################################

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  ##
  # Returns the first and last name combined.
  ##
  def name
    "#{first_name} #{last_name}"
  end
  
  ##
  # I don't want to have to confirm my flippin' password when updating my 
  # profile page.  I'm already authenticated dude.
  ##
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end  
  
  ##################################
  # Class Methods
  ##################################
  def self.find_for_database_authentication(conditions)
     login = conditions.delete(:login)
     where(conditions).where(["nickname = :value OR email = :value", { :value => login }]).first
   end    
end
