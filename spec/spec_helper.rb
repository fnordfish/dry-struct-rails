require "rubygems"
require "bundler/setup"

require 'combustion'
require 'active_support/dependencies'

Combustion.initialize! :action_controller, :action_view, :sprockets do
  config.eager_load = false
  config.cache_classes = false

  ActiveSupport::Dependencies.autoload_paths += Dir["#{config.root}/autoload-lib"]
end

require_relative "internal/lib/my_struct"

require 'rspec/rails'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.use_transactional_fixtures = true
end
