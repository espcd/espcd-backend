class Firmware < ApplicationRecord
  has_many :devices
  has_one :board_type

  validates :fqbn, :version, :content, presence: true

  has_one_attached :content

  after_create_commit { FirmwaresBroadcastJob.perform_later('create', self) }
  after_update_commit { FirmwaresBroadcastJob.perform_later('update', self) }
  after_destroy { FirmwaresBroadcastJob.perform_later('destroy', id) }
end
