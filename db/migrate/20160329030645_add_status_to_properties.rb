class AddStatusToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :status, :string, default: "pending"
  end
end
