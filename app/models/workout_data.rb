class WorkoutData < ApplicationRecord
  validates  :date, presence:true

  belongs_to :user
  
  has_one    :upper_body
  has_one    :arm 
  has_one    :leg
  has_one    :cardio
  has_one    :lower_body
end
