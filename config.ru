require './config/environment'


# Remember to migrate & to use UsersController/ OpponentsController
use Rack::MethodOverride
use UsersController
use OpponentsController
run ApplicationController
