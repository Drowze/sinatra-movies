require_relative 'app'

map('/') { run IndexController }
map('/users') { run UsersController } 
