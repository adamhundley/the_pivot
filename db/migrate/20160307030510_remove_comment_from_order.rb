class RemoveCommentFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :comment, :string
  end
end
