class ChangeProductAutoUpdateDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :products, :auto_update, true
  end
end
