class Film < ApplicationRecord
  belongs_to :user #filmには1つのユーザがいる
  default_scope -> { order(created_at: :desc) } #作成日時を降順(新しいものが上)で並べる
  validates :name, presence: true, length: { maximum: 127 }
  validates :iso, presence: true
end
