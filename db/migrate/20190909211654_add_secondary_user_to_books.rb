class AddSecondaryUserToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :secondary_user_id, :integer
  end
end
