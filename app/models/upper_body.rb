class UpperBody < ApplicationRecord
  belongs_to :workout_data

  has_many   :chests
  has_many   :shoulders
  has_many   :upper_backs
end

