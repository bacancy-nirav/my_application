class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_presence_of :text,length: { maximum: 50 }, :message => "Cannot be blank"

end