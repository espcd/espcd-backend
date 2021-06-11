class RemoveProductFromFirmware < ActiveRecord::Migration[6.1]
  def change
    remove_reference :firmwares, :product
  end
end
