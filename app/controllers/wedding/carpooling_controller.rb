module Wedding
  class CarpoolingController < ApplicationController
    private
      def get_or_load_all
        @car ||= Wedding::Car.new(driver: Wedding::Passenger.new) # For car's form.
        @shared_cars ||= Wedding::Car.shared.includes(:driver).includes(:passengers).load
      end
  end
end