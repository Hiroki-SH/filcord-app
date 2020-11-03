class Film < ApplicationRecord
  validates :name, :presence true, length: { maximum: 127 }
  validates :iso, :presence true
end
