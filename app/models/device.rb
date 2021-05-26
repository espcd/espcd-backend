class Device < ApplicationRecord
  belongs_to :firmware, optional: true
  belongs_to :product, optional: true

  validates :model, presence: true

  after_create :reload  # https://github.com/rails/rails/issues/34237

  after_create_commit { DevicesBroadcastJob.perform_later('create', self) }
  after_update_commit { DevicesBroadcastJob.perform_later('update', self) }
  after_destroy { DevicesBroadcastJob.perform_later('destroy', self) }
end
