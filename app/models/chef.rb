class Chef < ApplicationRecord
has_many :messages, dependent: :destroy
has_many :recipes, dependent: :destroy
 validates :chefname , presence: true, length: {maximum: 30}
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
 validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
before_save {self.email = email.downcase}
has_secure_password
validates :password, presence: true, length: {minimum: 5} , allow_nil: true
has_many :comments
has_many :likes, dependent: :destroy
end