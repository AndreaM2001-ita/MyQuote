class Quote < ApplicationRecord
  belongs_to :User
  belongs_to :Philosopher

  has_one :philosophers, dependent: :nullify
  has_one :users, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :category_quotes, dependent: :nullify
  has_many :categories, through: :category_quotes

end
