class LowerBack < ApplicationRecord
  belongs_to :lower_body

  validates :name, presence: true
  validates :weigth, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
