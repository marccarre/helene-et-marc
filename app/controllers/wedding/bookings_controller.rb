module Wedding
  class BookingsController < ApplicationController
    def index
      @bookings = Booking.includes(:guests).includes(:events).load
    end

    def show
      @booking = Booking.includes(:guests).includes(:events).find(params[:id])
    end

    def new
      @booking = Booking.new
      @booking.guests.build
      @booking.guests << Guest.new(category: Guest::CATEGORY[:adult])
      @booking.events.build
    end

    def create
      @booking = Booking.new(booking_params)

      respond_to do |format|
        #if verify_recaptcha(:model => @booking, :message => "Oh! It's an error with reCAPTCHA!") && @booking.save
        if (@booking.save)
          format.html { redirect_to wedding_booking_url(@booking), notice: 'Booking was successfully created.' }
        else
          format.html { render action: 'new', status: :unprocessable_entity }
        end
      end
    end

    private
    
      # Never trust parameters from the scary internet, only allow the white list through.
      def booking_params
        params.require(:wedding_booking).permit(
          :email,
          :phone,
          :coming,
          :comments,
          { guests_attributes: [:first_name, :family_name, :category, :menu, :_destroy] },
          event_ids: []
        )
      end
  end
end
