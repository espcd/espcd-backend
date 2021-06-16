class BoardType < ApplicationRecord
  belongs_to :product
  belongs_to :firmware, optional: true

  validates :fqbn, presence: true

  has_paper_trail only: [:firmware_id]

  after_create_commit { BoardTypesBroadcastJob.perform_later('create', self) }
  after_update_commit { BoardTypesBroadcastJob.perform_later('update', self) }
  after_destroy { BoardTypesBroadcastJob.perform_later('destroy', id) }
end
