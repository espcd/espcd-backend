class Device < ApplicationRecord
  belongs_to :firmware, optional: true
  belongs_to :product

  validates :model, presence: true
end
