class AddExpirationToTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :tokens, :expires_at, :datetime
  end
end
