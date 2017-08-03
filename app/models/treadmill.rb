class Treadmill < ApplicationRecord
  belongs_to :cardio

  validates :status_type, presence: true
  validates :speed, presence: true
  validates :time, presence: true
  validates :incline, presence: true
  validates :distance, presence: true
end
