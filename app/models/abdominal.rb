class Abdominal < ApplicationRecord
  belongs_to :lower_body

  validates :name, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
