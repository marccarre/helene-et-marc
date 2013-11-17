module Wedding
  class CarpoolingTripsController < ApplicationController
    before_action :set_carpooling_trip, only: [:show]

    def index
      @car = Car.includes(:driver).includes(:passengers).load
    end

    def show
    end

    def new
      @car = Car.new
    end

    def create
      @car = car.new(car_params)

      respond_to do |format|
        #if verify_recaptcha(:model => @car, :message => "Oh! It's an error with reCAPTCHA!") && @car.save
        if (@car.save)
          format.html { redirect_to wedding_carpooling_trip_url(@car), notice: 'Carpooling action was successfully saved.' }
        else
          format.html { render action: 'new' }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_carpooling_trip
        @booking = Booking.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def booking_params
        params.require(:wedding_car).permit!
      end
  end
end
