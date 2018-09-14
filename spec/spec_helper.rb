ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'rack/test'
require 'rspec'
require 'database_cleaner'

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do |c|
  c.include RSpecMixin

  c.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
