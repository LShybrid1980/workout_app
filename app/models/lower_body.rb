class LowerBody < ApplicationRecord

  belongs_to :workout_data

  has_many :abdominals, :backs
end
