#author: Rashmi Agarwal
#date: 18/08/2016
class BookingsController < ApplicationController
  
  def new
    @rooms = Room.all
  end

  def create
  end

  #==========================================
  #TODO: should be put into a service object
  #==========================================
  def check_availability
    @all_bookings = Booking.includes(:rooms).where("(start_date <= ? AND end_date >= ?) || (  start_date >= ? AND start_date <= ?)", 
      params[:checkin].to_date, params[:checkin].to_date, params[:checkin].to_date, params[:checkout].to_date)
    @checkin = params[:checkin]
    @checkout = params[:checkout]
  
    if params[:room_type].blank?
      @rooms_list = []
      ids = []
      @all_bookings.present? ? @all_bookings.each{|booking| ids << booking.rooms.pluck(:id)} : []
      avail_rooms = Room.all.where.not(id: ids.flatten)
      @rooms = avail_rooms
    else
      ids = []
      @all_bookings.present? ? @all_bookings.each{|booking| ids << booking.rooms.pluck(:id)} : []
      rooms_booked = Room.where(id: ids.flatten).pluck(:id)
      @rooms = Room.where("room_type=?", params[:room_type]).where.not(id: rooms_booked)
    end
  end

  #=============================================================================
  #TODO: should be put into a service object and refactored to make code more DRY
  #=============================================================================
  def reserve
    if (params[:checkin].present? && params[:checkout].present?)

      #Booking entry
      @booking = Booking.new
      @booking.customer_id = current_customer.id
      @booking.start_date = params[:checkin].to_date
      @booking.end_date = params[:checkout].to_date
      @booking.save


      #Find all booked deluxe rooms
      @all_bookings = Booking.includes(:rooms).where("(start_date <= ? AND end_date >= ?) || (start_date >= ? AND start_date <= ?)", params[:checkin], params[:checkin], params[:checkin], params[:checkout])
      ids = []
      booked_ids = @all_bookings.each{|booking| 
                                ids << booking.rooms.pluck(:id)
                              }
      avail_ids =  Room.where(room_type: "Deluxe").pluck(:id)-booked_ids

      if (params[:no_rooms_deluxe].to_i > 0)
        ids = avail_ids.take(params[:no_rooms_deluxe].to_i)
        for id in ids
          @details = BookingDetail.new
          @details.room_id = id
          @details.booking_id = @booking.id
          @details.save
        end
      end


      #Find all booked luxury rooms
      avail_ids =  Room.where(room_type: "Luxury").pluck(:id)-booked_ids

      if (params[:no_rooms_luxury].to_i > 0)
        ids = avail_ids.take(params[:no_rooms_luxury].to_i)
        for id in ids
          @details = BookingDetail.new
          @details.room_id = id
          @details.booking_id = @booking.id
          @details.save
        end
      end

      #Find all booked luxury suites
      avail_ids =  Room.where(room_type: "LS").pluck(:id)-booked_ids

      if (params[:no_rooms_ls].to_i > 0)
        ids = avail_ids.take(params[:no_rooms_ls].to_i)
        for id in ids
          @details = BookingDetail.new
          @details.room_id = id
          @details.booking_id = @booking.id
          @details.save
        end
      end

      #Find all booked presidential suites
      avail_ids =  Room.where(room_type: "PS").pluck(:id)-booked_ids

      if (params[:no_rooms_ps].to_i > 0)
        ids = avail_ids.take(params[:no_rooms_ps].to_i)
        for id in ids
          @details = BookingDetail.new
          @details.room_id = id
          @details.booking_id = @booking.id
          @details.save
        end
      end
    else
      flash.now[:danger] = "No booking date selected"
    end
    render "confirmation"
  end

  # private

  # def booking_params
 #    params.require(:bookings).permit(:no_rooms_deluxe, :no_rooms_luxury, :no_rooms_ls, :no_rooms_ps)
 #  end
end
