class Philosopher < ApplicationRecord
    has_many :quotes, dependent: :nullify
end
