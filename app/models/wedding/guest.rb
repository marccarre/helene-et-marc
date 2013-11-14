module Wedding
  class Guest < ActiveRecord::Base
    belongs_to :booking

    CATEGORY = {
      adult: 1,
      child: 2
    }

    MENU = {
      adult: 1,
      child: 2,
      nothing: 3
    }

    validates :first_name, presence: true
    validates :family_name, presence: true
    validates :category, presence: true, inclusion: { in: CATEGORY.values }
    validates :menu, presence: true, inclusion: { in: MENU.values }

    scope :coming, -> { where("booking_id IN (SELECT DISTINCT(booking_id) FROM bookings_events)") }
    scope :not_coming, -> { where("booking_id NOT IN (SELECT DISTINCT(booking_id) FROM bookings_events)") }

    scope :adults, -> { coming.where(category: MENU[:adult]) }
    scope :children, -> { coming.where(category: MENU[:child]) }
    scope :babies, -> { coming.where(category: MENU[:nothing]) }

    def is_adult?
      category == CATEGORY[:adult]
    end 

    def is_child?
      category == CATEGORY[:child]
    end

    def has_adult_menu?
      menu == MENU[:adult]
    end 

    def has_child_menu?
      menu == MENU[:child]
    end

    def has_nothing?
      menu == MENU[:nothing]
    end
  end
end
