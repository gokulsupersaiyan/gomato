class Rating < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  after_initialize :int_defaults

  def int_defaults
    self.upvotes ||= 0
    self.downvotes ||= 0
  end

  validates_numericality_of :starts, greater_than: 0, less_than: 6
  validates :review, length: { in: 50..255 }
end
