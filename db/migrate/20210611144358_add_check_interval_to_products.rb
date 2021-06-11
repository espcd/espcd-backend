class AddCheckIntervalToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :check_interval, :integer, default: 60
  end
end
