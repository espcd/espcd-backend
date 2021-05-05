# Source: https://gist.github.com/kylefox/00c3d9ca56df78282696ef6bfef5b2f4

class AddRecordUuidToActiveStorageAttachments < ActiveRecord::Migration[6.1]
  def change
    # After applying this migration, you'll need to manually go through your
    # attachments and populate the new `record_uuid` column.
    # If you're unable to do this, you'll probably have to delete all your attachments.
    # You've pretty much got useless garbage data if that's the case :(
    add_column :active_storage_attachments, :record_uuid, :uuid
  end
end
