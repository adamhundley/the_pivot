class RemoveColumnStatusFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :status
  end
end
