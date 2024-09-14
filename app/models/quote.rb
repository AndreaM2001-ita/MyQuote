class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :philosopher 

  has_many :comment, dependent: :destroy
  has_many :category_quote, dependent: :nullify
  has_many :category, through: :category_quotes

end
