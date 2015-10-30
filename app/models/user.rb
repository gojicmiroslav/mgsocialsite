class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable       

  validates :name,  presence: true, length: { maximum: 50 }    
  
  def feed
    Micropost.where('user_id = ?', self.id)
  end
end
