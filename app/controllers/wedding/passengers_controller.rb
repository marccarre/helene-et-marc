module Wedding
  class PassengersController < ApplicationController
    def create
      @passenger = Passenger.new(passengers_param)
      @car ||= parent

      respond_to do |format|
        #if @passenger.is_passenger? && verify_recaptcha(:model => @passenger, :message => "Oh! It's an error with reCAPTCHA!") && @passenger.save
        if @passenger.is_passenger? && @passenger.save
          logger.info("#{format}: successfully saved passenger: #{@passenger}")
          format.js { render "wedding/cars/create_passenger" }
          format.html { redirect_to wedding_transports_url, notice: 'Passenger was successfully added.' }
        else
          logger.info("#{format}: failed to save passenger: #{@passenger}")
          format.js { render "wedding/cars/create_passenger_error", status: :unprocessable_entity }
          format.html { render template: "wedding/transports" }
        end
      end
    end

    private
      def passengers
        @passengers ||= association.load
      end

      def passenger
        @passenger ||= association.find(params[:id])
      end

      def association
        if parent
          parent.passengers
        end
      end

      # Find and cache the parent based on the car_id in params:
      def parent
        @car ||= begin
          if id = params[:car_id]
            Car.find(id)
          end
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def passengers_param
        params.require(:wedding_passenger).permit! # TODO: add whitelist to check parameters.
      end
  end
end
