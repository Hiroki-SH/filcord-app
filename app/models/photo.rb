class Photo < ApplicationRecord
  belongs_to :film #photoには1つのfilmがいる
  has_one :user, through: :film

  validates :f_number, presence: true
  validates :shutter_speed, presence: true
  validates :film_id, presence: true
end
