# Uncomment the below if you want access to the Sidekiq dashboard:
# require 'sidekiq/web'

HeleneEtMarc::Application.routes.draw do

  root to: redirect('/wedding')

  scope '(:locale)' do
    namespace :wedding do
      resources :bookings, only: [:index, :new, :create, :show] #, defaults: { format: ['html', 'js'] }

      get '/', to: 'wedding#home' 
      get 'story', to: 'wedding#story'
      get 'photos', to: 'wedding#photos'
      get 'program', to: 'wedding#program'
      get 'calendar', to: 'wedding#calendar'
      get 'rsvp', to: 'bookings#new'

      get 'transports', to: 'wedding#transports'
      scope 'transports' do
        resources :cars, only: [:index, :create, :destroy] do
          resources :passengers, only: [:create, :destroy]
        end
      end

      get 'stay', to: 'wedding#stay'
      get 'area', to: 'wedding#area'
      get 'gifts', to: 'wedding#gifts'
      get 'contact', to: 'wedding#contact'
    end
  end

  # Uncomment the below if you want access to the Sidekiq dashboard:
  # mount Sidekiq::Web, at: '/sidekiq'
end
