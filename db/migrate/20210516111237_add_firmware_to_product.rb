class AddFirmwareToProduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :firmware, foreign_key: true, type: :uuid, optional: true
  end
end
