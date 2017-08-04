class LowerBack < ApplicationRecord
  belongs_to :workout_data

  validates :status_type, presence: true
  validates :weight, presence: true
  validates :set, presence: true
  validates :rep, presence: true
end
