class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :order, index: true, foreign_key: true
      t.string :comment

      t.timestamps null: false
    end
  end
end
