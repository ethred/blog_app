class User < ApplicationRecord
  before_validation :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes
  attribute :posts_counter, :integer, default: 0
  # attribute :email, :string
  # Validations
  validates :name, presence: true
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Methods
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def set_default_role
    self.role ||= 'admin'
  end
end
