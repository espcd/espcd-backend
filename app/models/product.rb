class Product < ApplicationRecord
  has_many :devices, dependent: :nullify
  has_many :firmwares, dependent: :nullify

  belongs_to :firmware, optional: true
end
