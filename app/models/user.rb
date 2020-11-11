class User < ApplicationRecord
  before_save { self.email = self.email.downcase } #save前にemailを全部小文字にする

  validates :name,  presence: true, length: { maximum: 64 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #正規表現を定数に代入
  validates :email, presence: true, length: { maximum: 255 }, 
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: true

  has_secure_password
  validates :password, presence: true

  #渡された文字列のハッシュ値を返す(クラスメソッド)
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    #三項演算子 z? ? x : yは以下と同義
    # if z?
    #  x
    # else
    #  y
    # end
    BCrypt::Password.create(string, cost: cost)
  end
end
