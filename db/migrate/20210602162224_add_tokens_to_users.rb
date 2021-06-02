class AddTokensToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :token, foreign_key: true, type: :uuid
  end
end
