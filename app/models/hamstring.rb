class Hamstring < ApplicationRecord
  belongs_to :leg

  validates :name, presence: true
  validates :weigth, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
