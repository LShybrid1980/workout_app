class UpperBody < ApplicationRecord

  belongs_to :workout_data

  has_many :chests, :shoulders
end
