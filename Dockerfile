FROM ruby:3.0

# ENV vars
ENV APP_PATH /app
ENV RAILS_ENV production
ENV RAKE_ENV production
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_SERVE_STATIC_FILES enable
ENV SECRET_KEY_BASE 3e7a500c79ae32fb78e6756f951439ff6898aee1a730c07853e082db9fa869ad5a2e60d22395d1c8d1ebbb7ca9be888626b0b5e65a5cbc7c9f7682fce61f144b

WORKDIR "$APP_PATH"

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler

COPY . "$APP_PATH"

COPY Gemfile "$APP_PATH/Gemfile"
COPY Gemfile.lock "$APP_PATH/Gemfile.lock"
RUN bundle config set path 'vendor/bundle'
RUN bundle config set without 'development:test'
RUN bundle config --local build.sassc --disable-march-tune-native
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3
RUN bundle clean
RUN bundle exec rails assets:precompile
EXPOSE 3000

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]
