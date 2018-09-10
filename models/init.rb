require 'sequel'
DB = Sequel.connect('sqlite://db/hello-sinatra.development.sqlite3')

require_relative 'user'
