class UpperBack < ApplicationRecord
  belongs_to :upper_back

  validates :name, presence: true
  validates :weigth, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
