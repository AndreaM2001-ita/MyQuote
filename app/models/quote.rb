class Quote < ApplicationRecord
  belongs_to :user, foreign_key: 'User_id', optional: true
  belongs_to :philosopher, foreign_key: 'Philosopher_id', optional: true

  attr_accessor :anonymous  #external atribute for controller 

  has_many :comment, dependent: :destroy
  has_many :category_quotes, dependent: :destroy
  has_many :categories, through: :category_quotes

  accepts_nested_attributes_for :philosopher
  accepts_nested_attributes_for :category_quotes

  private

end
