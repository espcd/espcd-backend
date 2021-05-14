class ChangeProductToDevices < ActiveRecord::Migration[6.1]
  def change
    remove_reference :devices, :product
    add_reference :devices, :product, foreign_key: true, type: :uuid, optional: true
  end
end
