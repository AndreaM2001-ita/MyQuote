class User < ApplicationRecord
    has_secure_password
    
    has_many :quotes, dependent: :destroy
    has_many :comments, dependent: :destroy
end
