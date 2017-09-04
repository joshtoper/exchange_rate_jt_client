FROM ruby:2.4.0-slim
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_ROOT /var/www/exchange_rate_jt_client
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
ADD Gemfile* $APP_ROOT/
RUN bundle install
ADD . $APP_ROOT
