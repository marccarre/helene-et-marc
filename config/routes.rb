HeleneEtMarc::Application.routes.draw do

  root to: redirect("/wedding")

  scope "(:locale)" do
    namespace :wedding do
      resources :bookings, only: [:index, :new, :create, :show] #, defaults: { format: ["html", "js"] }

      get "/", to: "wedding#home" 
      get "story", to: "wedding#story"
      get "photos", to: "wedding#photos"
      get "program", to: "wedding#program"
      get "rsvp", to: "bookings#new"

      get "transports", to: "wedding#transports"
      scope "transports" do
        resources :cars, only: [:create, :destroy] do
          resources :passengers, only: [:index, :create, :show, :destroy] #, defaults: { format: ["html", "js"] }
        end
      end

      get "stay", to: "wedding#stay"
      get "area", to: "wedding#area"
      get "gifts", to: "wedding#gifts"
      get "contact", to: "wedding#contact"
    end
  end

end
