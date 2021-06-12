class AddLockFirmwaresToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :lock_firmwares, :boolean, default: false
  end
end
