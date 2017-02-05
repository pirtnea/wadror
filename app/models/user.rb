class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true, length: { in: 3..30 }

  has_many :ratings
end
