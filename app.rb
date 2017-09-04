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
