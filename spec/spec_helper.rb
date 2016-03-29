require 'simplecov'
require "paperclip/matchers"
require 'rspec/active_model/mocks'
require 'factory_girl_rails'
require 'database_cleaner'

SimpleCov.start("rails")
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.include Paperclip::Shoulda::Matchers
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  RSpec.configure do |c|
    if c.filter_manager.inclusions.rules.include?(:live)
      StripeMock.toggle_live(true)
      puts "Running **live** tests against Stripe..."
    end
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end


end
