class Rating < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  after_initialize :int_defaults

  def int_defaults
    self.up_votes ||= 0
    self.down_votes ||= 0
  end

  validates_numericality_of :stars, greater_than: 0, less_than: 6
  validates :review, length: { in: 50..255 }
end
