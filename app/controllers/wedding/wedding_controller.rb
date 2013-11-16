module Wedding
  class WeddingController < ApplicationController
    def home
      render "wedding/home"
    end

    def story
      render "wedding/story"
    end

    def photos
      render "wedding/photos"
    end

    def program
      render "wedding/program"
    end

    def transports
      render "wedding/transports"
    end

    def stay
      render "wedding/stay"
    end

    def area
      render "wedding/area"
    end

    def gifts
      render "wedding/gifts"
    end

    def contact
      render "wedding/contact"
    end
  end
end