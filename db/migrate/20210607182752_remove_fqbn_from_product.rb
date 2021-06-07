class RemoveFqbnFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :fqbn
  end
end
