class Firmware < ApplicationRecord
  validates :version, presence: true

  has_one_attached :content
end
