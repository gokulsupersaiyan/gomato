class DishType < ApplicationRecord
  has_many :dishes, dependent: :restrict_with_error
end
