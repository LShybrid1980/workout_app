class Leg < ApplicationRecord
  belongs_to :workout_data

  has_many   :hamstrings
  has_many   :quads
  has_many   :calves
end
