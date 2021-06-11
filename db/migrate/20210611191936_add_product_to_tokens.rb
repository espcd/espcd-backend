class AddProductToTokens < ActiveRecord::Migration[6.1]
  def change
    add_reference :tokens, :product, foreign_key: true, type: :uuid
  end
end
