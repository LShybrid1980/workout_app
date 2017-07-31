class Arm < ApplicationRecord

  belongs_to :workout_data
  has_many   :biceps
  has_many   :triceps
end
