require './config/environment'
use Rack::MethodOverride

# Remember to migrate & to use UsersController/ OpponentsController

use UsersController
use OpponentsController
run ApplicationController
