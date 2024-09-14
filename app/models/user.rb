class User < ApplicationRecord
    has_secure_password
    
    has_many :Quotes, dependent: :destroy
    has_many :Comments, dependent: :destroy
end
