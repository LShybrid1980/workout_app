class UpperBack < ApplicationRecord
  validates :status_type, presence: true
  validates :weight, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
