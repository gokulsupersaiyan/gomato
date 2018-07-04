class User < ApplicationRecord
  has_many :ratings, dependent: :delete_all
end
