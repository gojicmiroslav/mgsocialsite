class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable       

  validates :name,  presence: true, length: { maximum: 50 }    

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  
  # Returns a user's status feed
  def feed
  	following_ids_subselect = "SELECT followed_id FROM relationships WHERE follower_id = :user_id" 
    Micropost.where("user_id IN (#{following_ids_subselect}) OR user_id = :user_id", user_id: self.id)
  end

  # Follows a user.
	# user.active_relationships.create(followed_id: user.id) - creates an active relationship 
	# associated with user
	# follower is impicit because Rails know on which object these methods are called
	def follow(other_user)
		active_relationships.create(followed_id: other_user.id)
	end

	# Unfollows a user.
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end

	# Returns true if the current user is following the other user.
	def following?(other_user)
		# if these exists, it's return true
		# => !active_relationships.find_by(followed_id: other_user.id).nil?
		# better way
		# we can do this because of this
		# has_many	:following, through: :active_relationships, source: :followed
		following.include?(other_user) # same as -> self.following.include?(other_user)		
	end
end
