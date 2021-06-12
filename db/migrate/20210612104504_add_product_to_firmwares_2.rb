class AddProductToFirmwares2 < ActiveRecord::Migration[6.1]
  def change
    add_reference :firmwares, :product, foreign_key: true, type: :uuid
  end
end
