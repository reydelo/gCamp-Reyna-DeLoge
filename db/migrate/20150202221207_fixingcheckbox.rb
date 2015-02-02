class Fixingcheckbox < ActiveRecord::Migration
  def change
    remove_column :tasks, :complete
    add_column :tasks, :complete, :boolean
  end
end
