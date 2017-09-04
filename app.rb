require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'exchange_rate_jt'
require 'sass/plugin/rack'
require_relative 'config/config'
require_relative 'lib/exchange_rate_conversion_request'
set :bind, '0.0.0.0'

get '/' do
  @currencies = ExchangeRateJt.currency_list
  slim :index
end

post '/' do
  begin
    runner = ExchangeRateConversionRequest.new(params)
    runner.run
    @result = runner.result_message
    @outcome = runner.outcome
    @currencies = ExchangeRateJt.currency_list
    slim :index
  end
end
