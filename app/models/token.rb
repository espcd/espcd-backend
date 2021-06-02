class Token < ApplicationRecord
  belongs_to :user

  after_create :reload  # https://github.com/rails/rails/issues/34237

  validates :title, presence: true
end
