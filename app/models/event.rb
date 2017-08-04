class Event < ApplicationRecord
  belongs_to :user

  validates :event_type, format: { with: /\A[a-zA-Z_]+\Z/ }
  validate :details_include_required_keys

  def details_include_required_keys
    if details.present? && !details.include?('id')
      errors.add(:details, "must include all required keys")
    end
  end
end
