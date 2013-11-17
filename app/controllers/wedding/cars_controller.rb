module Wedding
  class CarsController < ApplicationController
    def index
      @cars = Car.includes(:driver).includes(:passengers).load
    end

    def show
      @car = Car.includes(:driver).includes(:passengers).find(params[:id])
    end

    def new
      @car = Car.new
      @car.build_driver
      @car.car_poolers.build
    end

    def create
      @car = Car.new(carpooling_journey_params)

      respond_to do |format|
        #if verify_recaptcha(:model => @car, :message => "Oh! It's an error with reCAPTCHA!") && @car.save
        if (@car.save)
          format.html { redirect_to wedding_transports_url, notice: 'Carpooling journey was successfully saved.' }
        else
          format.html { render action: 'new' }
        end
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def carpooling_journey_params
        params.require(:wedding_car).permit! # TODO: add whitelist to check parameters.
      end
  end
end
