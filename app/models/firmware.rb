class Firmware < ApplicationRecord
  has_many :devices

  validates :version, presence: true

  has_one_attached :content
end
