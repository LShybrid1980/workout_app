class Leg < ApplicationRecord

  belongs_to :workout_data

  has_many :hamstrings, :quads, :calves
end
