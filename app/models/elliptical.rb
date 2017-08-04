class Elliptical < ApplicationRecord
  belongs_to :workout_data

  validates :status_type, presence: true
  validates :time, presence: true
  validates :speed, presence: true
  validates :distance, presence: true
  validates :resistance, presence: true
  validates :incline, presence: true
end
