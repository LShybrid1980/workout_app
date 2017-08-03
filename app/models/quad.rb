class Quad < ApplicationRecord
  belongs_to :leg

  validates :status_type, presence: true
  validates :weight, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
