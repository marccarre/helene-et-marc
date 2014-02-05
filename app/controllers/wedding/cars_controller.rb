module Wedding
  class CarsController < CarpoolingController
    def index
      get_or_load_all
    end

    def create
      @car = Car.new(car_params)

      respond_to do |format|
        #if verify_recaptcha(:model => @car, :message => "Oh! It's an error with reCAPTCHA!") && @car.save
        if @car.save
          logger.info("Successfully saved car: #{@car} (requested: #{@car.is_requested?}, shared: #{@car.is_shared?}). #{acceptable_formats}")
          format.js { 
            if @car.is_shared?
              get_or_load_all
              render 'wedding/cars/create_shared_car', status: :created
            elsif @car.is_requested?
              get_or_load_all
              render 'wedding/cars/create_requested_car', status: :created
            else
              render 'wedding/cars/car_errors', status: :bad_request
            end
          }
          format.html { redirect_to wedding_cars_url, status: :created, notice: 'Car was successfully added.' }
        else
          logger.info("Failed to save car: #{@car}. #{acceptable_formats}")
          format.js   { render 'wedding/cars/car_errors', status: :unprocessable_entity }
          format.html { 
            get_or_load_all
            render action: 'index', status: :unprocessable_entity 
          }
        end
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def car_params
        params.require(:wedding_car).permit! # TODO: add whitelist to check parameters.
      end
  end
end
