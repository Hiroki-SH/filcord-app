class Film < ApplicationRecord
  belongs_to :user #filmには1つのユーザがいる
  has_many :photos, dependent: :destroy #ユーザには複数のphotosがいる,filmの削除でphotoも消去
  default_scope -> { order(created_at: :desc) } #作成日時を降順(新しいものが上)で並べる
  validates :name, presence: true, length: { maximum: 127 }

  VALID_ISO_REGEX = /\A\d+\z/
  validates :iso, presence: true, format: {with: VALID_ISO_REGEX}
  validates :user_id, presence: true
end
