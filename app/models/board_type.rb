class BoardType < ApplicationRecord
  belongs_to :product

  validates :fqbn, presence: true
end
