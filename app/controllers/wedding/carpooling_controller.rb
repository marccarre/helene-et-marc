module Wedding
  class CarpoolingController < ApplicationController
    private
      def get_or_load_all
        @car ||= Wedding::Car.new(driver: Wedding::Passenger.new) # For car's form.
        @shared_cars ||= Wedding::Car.shared.includes(:driver).includes(:passengers).load
        
        # Dynamically create one passenger for each car's form, if not already existing.
        @shared_cars.each { |car| create_or_get_passenger_for(car) }
        @requested_cars ||= Wedding::Car.requested.includes(:driver).includes(:passengers).load
      end

      def create_or_get_passenger_for(car)
        name = "@passenger_#{car.id}"
        if !instance_variable_get(name).present?
          instance_variable_set(name, Wedding::Passenger.new)
        end
        instance_variable_get(name)
      end
  end
end