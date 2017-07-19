class AddReadToMessages < ActiveRecord::Migration[5.0]
  def up
    add_column :messages, :read, :boolean, default: false
    remove_column :users, :messages_read_at
  end

  def down
    add_column :users, :messages_read_at, :datetime
    remove_column :messages, :read
  end
end
