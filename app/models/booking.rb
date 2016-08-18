class Booking < ApplicationRecord
	has_many :booking_details
	has_many :rooms, through: :booking_details
	has_many :customers, through: :booking_details
end
