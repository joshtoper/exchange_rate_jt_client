require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'exchange_rate_jt'
require 'sass/plugin/rack'
require_relative 'config/config'
require_relative 'lib/exchange_rate_conversion_request'

class App < Sinatra::Base
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

  post '/update_exchange_rates' do
    begin
      ExchangeRateJt.update_exchange_rates
      status 200
    rescue
      status 500
    end
  end
end
