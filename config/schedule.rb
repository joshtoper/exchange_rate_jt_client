# This rather depends on where the project would be hosted.
# If hosted on Heroku then it's likely that I'd use
# Heroku's scheduler plugin, but if somewhere else (AWS, for instance)
# this would work with the native crontab.

every 1.day, at: '06:00 am' do
  runner 'ExchangeRateJt.update_exchange_rates'
end
