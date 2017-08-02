class Cardio < ApplicationRecord
  belongs_to :workout_data

  has_many   :treadmills
  has_many   :ellipticals
end
