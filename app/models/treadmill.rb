class Treadmill < ApplicationRecord
  belongs_to :workout_data

  validates :status_type, presence: true
  validates :speed, presence: true
  validates :time, presence: true
  validates :incline, presence: true
  validates :distance, presence: true
end
