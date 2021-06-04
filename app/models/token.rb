class Token < ApplicationRecord
  belongs_to :user

  after_create :reload  # https://github.com/rails/rails/issues/34237

  validates :title, presence: true

  after_create_commit { TokensBroadcastJob.perform_later('create', self) }
  after_update_commit { TokensBroadcastJob.perform_later('update', self) }
  after_destroy { TokensBroadcastJob.perform_later('destroy', id) }
end
