class RenameModelToFqbn < ActiveRecord::Migration[6.1]
  def change
    rename_column :devices, :model, :fqbn
    rename_column :firmwares, :model, :fqbn
    rename_column :products, :model, :fqbn
  end
end
