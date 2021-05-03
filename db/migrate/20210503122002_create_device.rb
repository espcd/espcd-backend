class CreateDevice < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.string :title
      t.text :description
      t.string :model
      t.string :chip_id
      t.datetime :last_seen

      t.timestamps
    end
  end
end
