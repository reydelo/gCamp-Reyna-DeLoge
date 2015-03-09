class ChangeOwnerColumn < ActiveRecord::Migration
  def change
    remove_column :memberships, :role, :integer
    add_column :memberships, :role, :integer, default: 0
  end
end
