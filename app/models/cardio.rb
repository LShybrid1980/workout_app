class Cardio < ApplicationRecord

  belongs_to :workout_data

  has_many :threadmills, :ellipticals
end
