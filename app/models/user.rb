#virtual attributes
#password:string
#password_confirmation:string

class User < ApplicationRecord
    has_secure_password
    has_many :articles
    validates :email, presence: true, format: {with: /\A(.+)@(.+)\z/ , message:"must be a valid email address" }, uniqueness: true
end
