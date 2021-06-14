class CreateBoardType < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :board_types, id: :uuid do |t|
      t.string :fqbn
      t.references :firmware, foreign_key: true, type: :uuid
      t.references :product, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
