class Product < ApplicationRecord
  has_many :devices
  has_many :firmwares
end
