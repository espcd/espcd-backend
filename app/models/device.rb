class Device < ApplicationRecord
  validates :model, :chip_id, presence: true
end
