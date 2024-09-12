class CategoryQuote < ApplicationRecord
  belongs_to :quote
  belongs_to :category
end
