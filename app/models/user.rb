class User < ApplicationRecord
  before_save { self.email = self.email.downcase } #save前にemailを全部小文字にする

  validates :name,  presence: true, length: { maximum: 64 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #正規表現を定数に代入
  validates :email, presence: true, length: { maximum: 255 }, 
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: true
end
