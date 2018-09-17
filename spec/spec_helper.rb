ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'rack/test'
require 'rspec'
require 'factory_bot'
require_relative 'support/factory_bot_sequel_patches'
require 'database_cleaner'

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do |c|
  c.include RSpecMixin

  c.filter_run_when_matching :focus

  c.before(:suite) do
    FactoryBot.definition_file_paths = [File.join(__dir__, 'support', 'factories')]
    FactoryBot.find_definitions
  end

  c.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
