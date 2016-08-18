class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
    	t.references :customer
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
