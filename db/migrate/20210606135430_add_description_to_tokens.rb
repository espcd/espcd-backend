class AddDescriptionToTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :tokens, :description, :text
  end
end
