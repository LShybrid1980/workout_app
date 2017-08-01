class Threadmill < ApplicationRecord
  belongs_to :cardio

  validates :name, presence: true
  validates :speed, presence: true
  validates :time, presence: true
  validates :incline, presence: true
  validates :distance, presence: true
end
