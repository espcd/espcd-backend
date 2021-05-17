class Device < ApplicationRecord
  belongs_to :firmware, optional: true
  belongs_to :product, optional: true

  validates :model, presence: true

  after_create :reload  # https://github.com/rails/rails/issues/34237
end
