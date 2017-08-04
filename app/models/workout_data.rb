class WorkoutData < ApplicationRecord
  validates  :date, presence:true

  belongs_to :user
  
  has_many   :abdominals
  has_many   :biceps 
  has_many   :calves
  has_many   :ellipticals
  has_many   :forearms
  has_many   :hamstrings
  has_many   :lower_backs
  has_many   :quads
  has_many   :shoulders
  has_many   :treadmills
  has_many   :triceps
  has_many   :upper_backs
end
