ExchangeRateJt.configure do |config|
  config.data_store = PStore.new('store.exchange_rates')
  config.data_store_type = :pstore
  config.source = :ecb
  config.default_currency = :EUR
end
