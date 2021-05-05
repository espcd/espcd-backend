class Device < ApplicationRecord
  belongs_to :firmware, optional: true

  validates :model, presence: true
end
