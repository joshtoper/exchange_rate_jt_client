require 'sinatra'
require 'sinatra/reloader'
require 'exchange_rate_jt'
require_relative 'config/config'

set :bind, '0.0.0.0'

get '/' do
  "We are go!"
end
