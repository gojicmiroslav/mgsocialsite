class Micropost < ActiveRecord::Base
  belongs_to :user

  # Use this macro in your model to set a default scope for all operations on the model.
  # Proc

  # raw SQL
  # default_scope -> { order("created_at DESC") }

  # Since - od Rails 4
	default_scope -> { order(created_at: :desc) }  
	# picture - name of the attribute
	mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true
  validate  :picture_size

  private

  # Validates the size of an uploaded picture
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
