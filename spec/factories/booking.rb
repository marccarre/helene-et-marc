FactoryGirl.define do
  factory :booking do
    comments "John has allergies to sesame. Mary is vegan."

    # adults {|adult| [adult.association(:adult_guest)] }

    # Callback to address factory, to avoid infinite loop:
    after(:build) do |booking, evaluator|
        booking.address = FactoryGirl.build(:address, :booking => booking)
        booking.adults << FactoryGirl.build(:adult_guest, :booking => booking)
        #user_account.users = FactoryGirl.build_list(:user, 5, :account=>user_account)
    end
  end
end