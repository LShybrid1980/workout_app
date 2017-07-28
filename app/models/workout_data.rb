class WorkoutData < ApplicationRecord
  belongs_to :user

  has_many :upper_bodies, :lower_bodies, :arms, :legs, :cardios
end
