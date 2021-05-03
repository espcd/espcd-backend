class CreateFirmwares < ActiveRecord::Migration[6.1]
  def change
    create_table :firmwares do |t|
      t.string :version
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
