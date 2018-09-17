require_relative 'app'

map('/') { run IndexController }
map('/users') { run UsersController } 
map('/users/:id/backpack') { run Users::BackpackController }
