class CreateBookingDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :booking_details do |t|
    	t.references :booking
    	t.references :room
    	
      t.timestamps
    end
  end
end
