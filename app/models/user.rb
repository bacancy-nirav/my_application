class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :username,:presence => true,:uniqueness => {:case_sensitive => false}
  include Amistad::FriendModel
  
  mount_uploader :picture, PictureUploader
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validate  :picture_size

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :lockable, :authentication_keys => [:login]


  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def full_name
    "#{first_name} #{last_name}"
  end

   def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
    end

  # def full_name
  #   puts "================================================"
  #   puts self.inspect
  #   self.first_name
  #   puts "================================================"
  # end

  # def self.test
  #    puts "================================================"
  #   puts self.inspect
  #   self.first_name
  #   User.first_name
  #   puts "================================================"
  # end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end