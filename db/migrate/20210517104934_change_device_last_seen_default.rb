class ChangeDeviceLastSeenDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :devices, :last_seen, -> { 'CURRENT_TIMESTAMP' }
  end
end
