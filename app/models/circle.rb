class Circle < ActiveRecord::Base
  validates :user, :name, presence: true
  validates :name, length: { minimum: 4 }
  
  belongs_to :user, inverse_of: :circles
  has_many :memberships, class_name: CircleMembership, 
    foreign_key: :circle_id, inverse_of: :circle
  has_many :members, through: :memberships, source: :member
  
  has_many :post_shares, inverse_of: :circle
  has_many :posts, through: :post_shares, source: :post
end
