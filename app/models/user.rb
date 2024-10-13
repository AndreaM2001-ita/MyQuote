class User < ApplicationRecord
    has_secure_password
    #check that the email has a valid format
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
    
    has_many :Quotes, dependent: :destroy
    has_many :Comments, dependent: :destroy
end
