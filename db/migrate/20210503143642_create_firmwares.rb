class CreateFirmwares < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :firmwares, id: :uuid do |t|
      t.string :version
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
