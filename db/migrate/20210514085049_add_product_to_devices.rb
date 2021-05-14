class AddProductToDevices < ActiveRecord::Migration[6.1]
  def change
    add_reference :devices, :product, foreign_key: true, type: :uuid
  end
end
