module Wedding
  class Car < ActiveRecord::Base
    has_one :driver, -> { where(category: Passenger::CATEGORY[:driver]) }, class_name: "Passenger", inverse_of: :car, dependent: :destroy
    has_many :passengers, -> { where(category: Passenger::CATEGORY[:passenger]) }, class_name: "Passenger", inverse_of: :car, dependent: :destroy

    accepts_nested_attributes_for :driver
    accepts_nested_attributes_for :passengers

    CATEGORY = {
      share: 1,
      request: 2
    }

    MIN_AVAILABLE_SEATS = 1
    MAX_AVAILABLE_SEATS = 20

    validates :driver, presence: true
    validates :passengers, length: { maximum: @available_seats || MAX_AVAILABLE_SEATS }
    validates :from, presence: true
    validates :to, presence: true
    validates :departure_time, presence: true
    validates :available_seats, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_AVAILABLE_SEATS, less_than_or_equal_to: MAX_AVAILABLE_SEATS }
    validates :category, presence: true, inclusion: { in: CATEGORY.values }

    scope :shared, -> { where(category: CATEGORY[:share]) }
    scope :requested, -> { where(category: CATEGORY[:request]) }

    def is_shared? 
      category == CATEGORY[:share]
    end

    def is_requested? 
      category == CATEGORY[:request]
    end

    def to_s
      return to_json(include: :driver).to_s
    end
  end
end