class Philosopher < ApplicationRecord
    has_many :Quotes, dependent: :nullify

    validates :birthYear, presence: false

end
