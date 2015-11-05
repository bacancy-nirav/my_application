class Post < ActiveRecord::Base
  
  has_many :post_comments, class_name: 'Comment', dependent: :destroy
  belongs_to :user
  default_scope { order('created_at DESC') }
  validates_presence_of :content,length: { maximum: 50 }, :message => "Cannot be blank"
  validates_presence_of :visibility, presence:true, :message => "Select visibility.."

  mount_uploader :image, PictureUploader
  validate  :picture_size
  paginates_per 5

  private
    def picture_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end
end
