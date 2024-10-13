class Comment < ApplicationRecord
  attr_accessor :user_id, :quote_id

  belongs_to :user, foreign_key: :User_id  
  belongs_to :quote, foreign_key: :Quote_id

  #both the user and quopte have to be present
  validates :user, presence: true
  validates :quote, presence: true
end
