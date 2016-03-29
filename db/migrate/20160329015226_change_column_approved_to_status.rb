class ChangeColumnApprovedToStatus < ActiveRecord::Migration
  def change
    rename_column :properties, :approved, :status
  end
end
