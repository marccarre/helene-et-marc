module Wedding
  class PassengersController < CarpoolingController
    protect_from_forgery except: [:delete]
    
    def index
      get_or_load_all
      render template: 'wedding/cars/index'
    end

    def create
      passenger = instance_variable_set("@passenger_#{params[:car_id]}", Passenger.new(passenger_params))

      respond_to do |format|
        #if passenger.is_passenger? && verify_recaptcha(:model => passenger, :message => "Oh! It's an error with reCAPTCHA!") && passenger.save
        if passenger.is_passenger? && passenger.save
          logger.info("Successfully saved passenger: #{passenger}. #{acceptable_formats}")
          format.js   { render 'wedding/cars/create_passenger', locals: { passenger: passenger }, status: :created }
          format.html { redirect_to wedding_cars_url, status: :created, notice: t('carpooling.passenger_successfully_added') }
        else
          logger.info("Failed to save passenger: #{passenger}. #{acceptable_formats}")
          format.js   { render 'wedding/cars/create_passenger_error', locals: { passenger: passenger }, status: :unprocessable_entity }
          format.html { 
            get_or_load_all
            render template: 'wedding/cars/index', status: :unprocessable_entity 
          }
        end
      end
    end

    def destroy
      passenger.destroy
      respond_to do |format|
        format.html { redirect_to wedding_cars_url, notice: t('carpooling.passenger_successfully_deleted') }
        format.js   { render 'wedding/cars/destroy_passenger', locals: { passenger: passenger } }
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
      def passenger_params
        params.require(:wedding_passenger).permit(:_destroy, :car_id, :category, :first_name, :family_name, :email, :phone)
      end
  end
end
