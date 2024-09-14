class Philosopher < ApplicationRecord
    has_many :Quotes, dependent: :nullify
end
