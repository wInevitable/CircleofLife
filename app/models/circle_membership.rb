class CircleMembership < ActiveRecord::Base

  validates :circle, :member, presence: true
  
  belongs_to :circle, inverse_of: :memberships
  belongs_to :member, class_name: User, foreign_key: :member_id, 
            inverse_of: :circle_memberships
end
