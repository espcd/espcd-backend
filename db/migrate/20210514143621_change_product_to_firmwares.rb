class ChangeProductToFirmwares < ActiveRecord::Migration[6.1]
  def change
    remove_reference :firmwares, :product
    add_reference :firmwares, :product, foreign_key: true, type: :uuid, optional: true
  end
end
