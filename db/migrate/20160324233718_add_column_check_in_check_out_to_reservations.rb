class AddColumnCheckInCheckOutToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :checkin, :date
    add_column :reservations, :checkout, :date
  end
end
