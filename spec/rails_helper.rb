# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'

#Phantomjs.path
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
#Capybara.register_driver :poltergeist do |app|
#    Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
#end
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
#require 'support/easy_screenshots'
#require 'support/sign_up_and_login'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_driver    = :poltergeist

ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  # rest of the file...

  #config.add_setting :screenshots_dir
  #config.screenshots_dir = "#{::Rails.root}/spec/screenshots"
  #config.include(EasyScreenshots, type: :feature)
  #config.include(FactoryGirl::Syntax::Methods)
  config.include(Devise::TestHelpers, type: :controller)

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :type => :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end