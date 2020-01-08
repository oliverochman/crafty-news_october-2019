require 'spec_helper'
require 'capybara/rspec'

ENV['RAILS_ENV'] ||= 'test'
require 'coveralls'
Coveralls.wear_merged!('rails')

require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }


abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Webdrivers::Chromedriver.required_version = 2.44
chrome_options = %w[ headless
                     no-sandbox
                     disable-popup-blocking
                     disable-gpu
                     disable-infobars
                     disble-dev-shm-usage
                     auto-open-devtools-for-tabs]

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: chrome_options)

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.server = :puma
Capybara.javascript_driver = :chrome

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.file_fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include SessionHelpers, type: :feature
  config.include Warden::Test::Helpers
  config.before(:each, type: :feature) do
    StripeMock.start
  end
  config.after(:each, type: :feature) do
    StripeMock.stop
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
