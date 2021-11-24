FROM ruby:3.0

# ENV vars
ENV APP_PATH /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler
WORKDIR "$APP_PATH"
COPY Gemfile "$APP_PATH/Gemfile"
COPY Gemfile.lock "$APP_PATH/Gemfile.lock"
RUN bundle config set path 'vendor/bundle'
RUN bundle config set without 'development:test'
RUN bundle config --local build.sassc --disable-march-tune-native
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3
RUN bundle clean
RUN bundle exec rails assets:precompile
COPY . "$APP_PATH"
EXPOSE 3000

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]
