class Product < ApplicationRecord
  has_many :devices, dependent: :nullify
  has_many :tokens, dependent: :nullify
  has_many :board_types, dependent: :destroy

  after_create_commit { ProductsBroadcastJob.perform_later('create', self) }
  after_update_commit { ProductsBroadcastJob.perform_later('update', self) }
  after_destroy { ProductsBroadcastJob.perform_later('destroy', id) }
end
