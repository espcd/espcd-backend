class Product < ApplicationRecord
  has_many :devices, dependent: :nullify
  has_many :firmwares, dependent: :nullify

  after_create_commit { ProductsBroadcastJob.perform_later('create', self) }
  after_update_commit { ProductsBroadcastJob.perform_later('update', self) }
  after_destroy { ProductsBroadcastJob.perform_later('destroy', id) }
end
