class Micropost < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length:{maximum: 140}
  validate :picture_size

  private
  	def picture_size
  		if picture.size > 2.megabytes
  			errors.add(:picture, "should be less than 2 mb")
  		end
  	end
end
