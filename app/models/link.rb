class Link < ActiveRecord::Base
  validates :post, :url, presence: true
  belongs_to :post, inverse_of: :links
end
