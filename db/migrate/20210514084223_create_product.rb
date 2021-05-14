class CreateProduct < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :products, id: :uuid do |t|
      t.string :title
      t.string :description
      t.boolean :auto_update
      t.belongs_to :device
      t.belongs_to :firmware

      t.timestamps
    end
  end
end
