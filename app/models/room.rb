class Room < ApplicationRecord
  has_many :bookings, through: :booking_details
end
