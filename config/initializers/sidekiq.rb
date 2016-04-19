require 'sidekiq'

# Copies locale from original thread:
# See also: https://github.com/mperham/sidekiq/issues/750
require 'sidekiq/middleware/i18n' 

# Client configuration:
Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

# Server configuration done using app/config/sidekiq.yml
# See also: http://manuelvanrijn.nl/sidekiq-heroku-redis-calc/
