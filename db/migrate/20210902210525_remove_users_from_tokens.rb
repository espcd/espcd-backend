class RemoveUsersFromTokens < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :token
  end
end
