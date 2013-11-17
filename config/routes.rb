HeleneEtMarc::Application.routes.draw do

  root to: redirect("/wedding")

  scope "(:locale)" do
    namespace :wedding do
      resources :bookings, only: [:index, :new, :create, :show]

      get "/", to: "wedding#home" 
      get "story", to: "wedding#story"
      get "photos", to: "wedding#photos"
      get "program", to: "wedding#program"
      get "rsvp", to: "bookings#new"

      get "transports", to: "wedding#transports"
      scope ":transports" do
        resources :cars, only: [:index, :new, :create, :show]
      end

      get "stay", to: "wedding#stay"
      get "area", to: "wedding#area"
      get "gifts", to: "wedding#gifts"
      get "contact", to: "wedding#contact"
    end
  end

end
