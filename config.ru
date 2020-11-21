# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run ApplicationController
use Rack::MethodOverride
use PostController
use UserController