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

    def calendar
      send_file("#{Rails.root}/app/assets/files/#{t('program.calendar_file')}",
              filename: t('program.calendar_file'),
              type: 'text/calendar',
              disposition: 'attachment')
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