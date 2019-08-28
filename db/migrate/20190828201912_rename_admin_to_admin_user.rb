class RenameAdminToAdminUser < ActiveRecord::Migration[6.0]
  def change
    rename_table :admins, :admin_users
  end
end
