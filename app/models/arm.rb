class Arm < ApplicationRecord

  belongs_to :workout_data
  has_many :biceps, :triceps
end
