class CustomersController < ApplicationController
  def welcome
  	@bookings = Booking.where(customer_id: current_customer.id)
  	@rooms = Hash.new
  	@bookings.each{|booking| 
  	  @rooms[booking.id]  = BookingDetail.where(booking_id: booking.id).collect(&:room_id).map{|i| Room.find(i).room_type}
  	}
  end
end
