class CreateReservationNights < ActiveRecord::Migration
  def change
    create_table :reservation_nights do |t|
      t.references :reservation, index: true, foreign_key: true
      t.date :night
    end
  end
end
