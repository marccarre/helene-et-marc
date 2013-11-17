module Wedding
  class BookingsController < ApplicationController
    before_action :set_booking, only: [:show]

    def index
      @bookings = Booking.includes(:guests).includes(:events).load
    end

    def show
    end

    def new
      @booking = Booking.new
      @booking.build_address
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
          format.html { render action: 'new' }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_booking
        @booking = Booking.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def booking_params
        params.require(:wedding_booking).permit!
        # MAKE SURE WE CAN'T UPDATE BY REFUSING "id"
        # params.require(:wedding_booking).permit(
        #     :comments, 
        #     adults_attributes: [:first_name, :family_name, :_destroy], 
        #     children_attributes: [:first_name, :family_name, :birth_date, :child_menu, :_destroy], 
        #     address_attributes: [:email, :phone, :address, :postcode, :city, :country]
        # )
      end
  end
end
