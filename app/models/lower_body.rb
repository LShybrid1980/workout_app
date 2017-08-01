class LowerBody < ApplicationRecord

  belongs_to :workout_data

  has_many   :abdominals
  has_many   :lower_backs
end
