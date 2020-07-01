class User < ApplicationRecord

    has_many :worlds
    has_many :characters

    has_many :items, through: :characters
    has_many :characters, through: :worlds

    validates :username, presence: true, length: { maximum: 15 }, uniqueness: true

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email_address, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true, length: { minimum: 6 }


end