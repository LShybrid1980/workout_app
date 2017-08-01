class Tricep < ApplicationRecord
  belongs_to :arm

  validates :name, presence: true
  validates :weigth, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
