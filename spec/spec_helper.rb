# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'sidekiq/testing'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


require 'simplecov'
SimpleCov.start do
  # Do NOT generate any coverage stats for:
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'

  # Group coverage stats by:
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
end if ENV['COVERAGE'] # Run test coverage analysis only when COVERAGE=true, e.g. : COVERAGE=true rake spec


RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Sidekiq configuration:
  # See also: https://github.com/mperham/sidekiq/wiki/Testing
  config.before(:each) do |example_method|
    # Clears out the jobs for tests using the fake testing
    Sidekiq::Worker.clear_all
    # Get the current example from the example_method object
    example = example_method.example

    if example.metadata[:sidekiq] == :fake
      # A test fake that pushes all jobs into a jobs array
      Sidekiq::Testing.fake! 
    elsif example.metadata[:sidekiq] == :inline
      # An inline mode that runs the job immediately instead of enqueuing it
      Sidekiq::Testing.inline!
    elsif example.metadata[:type] == :acceptance
      # An inline mode that runs the job immediately instead of enqueuing it
      Sidekiq::Testing.inline!
    else
      # The test harness can be disabled. Jobs are pushed to redis.
      Sidekiq::Testing.fake!
    end
  end

end

class String
  def remove_non_ascii(replacement='')
    self.gsub(/[\u0080-\u00ff]/, replacement)
  end

  def remove_non_alnum(replacement='')
    self.gsub(/[^0-9a-z ]/i, replacement)
  end
  
  def tokenize(replacement=' ')
    self.remove_non_alnum(replacement).split(replacement)
  end
end
