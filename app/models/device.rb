class Device < ApplicationRecord
  belongs_to :firmware, optional: true
  belongs_to :product, optional: true

  validates :model, presence: true
end
