class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :devices, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :model
      t.string :chip_id
      t.datetime :last_seen

      t.timestamps
    end
  end
end
