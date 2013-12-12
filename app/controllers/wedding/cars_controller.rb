module Wedding
  class CarsController < ApplicationController
    def create
      @car = Car.new(carpooling_journey_params)

      respond_to do |format|
        #if (verify_recaptcha(model: @car, message: "Oh! It's an error with reCAPTCHA!") && @car.save)
        #if (@car.save)
        #else
        #end
        
        format.js {
          logger.info("*** JS VIEW ***")
          if (@car.save)
            if @car.is_shared?
              render "wedding/cars/create_shared_car"
            elsif @car.is_requested?
              render "wedding/cars/create_requested_car"
            else 
              render "wedding/cars/create_car_error", status: :bad_request
            end
          else 
            render "wedding/cars/create_car_error", status: :unprocessable_entity
          end
        }

        format.html { 
          logger.info("*** HTML VIEW: render 'wedding/transports' ***")
          #render "wedding/transports"
          #redirect_to(wedding_transports_url)
          render template: "wedding/transports" 
        }
      end
    end

    private
      def car 
        @car ||= Car.includes(:driver).includes(:passengers).find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def carpooling_journey_params
        params.require(:wedding_car).permit! # TODO: add whitelist to check parameters.
      end
  end
end
