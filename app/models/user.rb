class User < ApplicationRecord
  attr_accessor :remember_token #仮想属性

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

  #ランダムな22文字の文字列を返す(トークンともいう)(クラスメソッド)
  def User.new_token
    SecureRandom.urlsafe_base64 #64種類の文字から構成される22文字のランダムな文字列を生成するメソッド
  end

  #永続セッションのためにユーザをデータベースに保存
  def remember
    self.remember_token = User.new_token #仮想属性であるremember_tokenに保存
    update_attribute(:remember_digest, User.digest(self.remember_token)) 
      #remember_tokenをハッシュ化し、データベースに保存(バリデーション素通り)
  end

  #渡されたトークンがダイジェストと一致すればtrueを返す
  def authenticated?(remember_token)
    return false if self.remember_digest.nil?
    BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  end

  #データベース内のトークンダイジェストを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

end
