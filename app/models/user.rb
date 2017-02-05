class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { in: 3..30 }
  validates :password, length: { minimum: 4 }, format: { with: /.*(\d.*[A-Z]|[A-Z].*).*/ }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :ratings
end
