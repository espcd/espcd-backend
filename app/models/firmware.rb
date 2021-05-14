class Firmware < ApplicationRecord
  has_many :devices
  belongs_to :product, optional: true

  validates :version, :content, presence: true

  has_one_attached :content
end
