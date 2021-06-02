class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :tokens, id: :uuid do |t|
      t.string :title
      t.uuid :token, default: 'gen_random_uuid()'
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
