class AddDateTimeToProperties < ActiveRecord::Migration
  def change
    add_timestamps(:properties)
  end
end
