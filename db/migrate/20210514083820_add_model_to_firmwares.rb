class AddModelToFirmwares < ActiveRecord::Migration[6.1]
  def change
    add_column :firmwares, :model, :string
  end
end
