module Wedding
  class CarsController < ApplicationController
    def create
      @car = Car.new(car_params)

      respond_to do |format|
        #if @car.is_passenger? && verify_recaptcha(:model => @car, :message => "Oh! It's an error with reCAPTCHA!") && @car.save
        if @car.save
          logger.info("Successfully saved car: #{@car} (requested: #{@car.is_requested?}, shared: #{@car.is_shared?}). #{acceptable_formats}")
          format.js { 
            if @car.is_shared?
              render 'wedding/cars/create_shared_car'
            elsif @car.is_requested?
              render 'wedding/cars/create_requested_car'
            else
              render 'wedding/cars/create_car_error', status: :bad_request
            end
          }
          format.html { redirect_to wedding_cars_url, notice: 'Passenger was successfully added.' }
        else
          logger.info("Failed to save car: #{@car}. #{acceptable_formats}")
          format.js   { render 'wedding/cars/create_car_error', status: :unprocessable_entity }
          format.html { render template: 'wedding/cars/index' }
        end
      end
    end

    private
      def car
        @car ||= Car.includes(:driver).includes(:passengers).find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def car_params
        params.require(:wedding_car).permit! # TODO: add whitelist to check parameters.
      end
  end
end
