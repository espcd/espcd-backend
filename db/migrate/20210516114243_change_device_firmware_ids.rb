class ChangeDeviceFirmwareIds < ActiveRecord::Migration[6.1]
  def change
    remove_column :devices, :available_firmware_id
    remove_column :devices, :current_firmware_id
    add_reference :devices, :firmware, foreign_key: true, type: :uuid, optional: true
  end
end
