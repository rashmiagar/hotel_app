class BookingDetail < ApplicationRecord
  belongs_to :customer
  belongs_to :booking
  belongs_to :room
end
