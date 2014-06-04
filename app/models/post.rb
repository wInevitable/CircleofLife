class Post < ActiveRecord::Base
  
  validates :author, :body, presence: true
  
  belongs_to :author, class_name: User, foreign_key: :user_id, inverse_of: :posts
  has_many :links, inverse_of: :post
  has_many :post_shares, inverse_of: :post
  has_many :circles, through: :post_shares, source: :circle
end
