class WorkoutData < ApplicationRecord
  validates  :date, presence:true

  belongs_to :user
  has_many   :upper_bodies
  has_many   :arms 
  has_many   :legs 
  has_many   :cardios
  has_many   :lower_bodies
end
