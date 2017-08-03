class LowerBack < ApplicationRecord
  belongs_to :lower_body

  validates :status_type, presence: true
  validates :weight, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
