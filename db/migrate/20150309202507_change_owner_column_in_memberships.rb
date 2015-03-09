class ChangeOwnerColumnInMemberships < ActiveRecord::Migration
  def change
    remove_column :memberships, :owner, :boolean
    add_column :memberships, :role, :integer
  end
end
