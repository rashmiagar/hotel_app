class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable
         :recoverable, :rememberable, :trackable, :validatable

   has_many :booking_details
   has_many :bookings, through: :booking_details
end
