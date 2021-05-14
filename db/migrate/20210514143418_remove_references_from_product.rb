class RemoveReferencesFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_reference :products, :device
    remove_reference :products, :firmware
  end
end
