FROM ruby:3.0

# ENV vars
ENV APP_PATH /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR "$APP_PATH"
COPY Gemfile "$APP_PATH/Gemfile"
COPY Gemfile.lock "$APP_PATH/Gemfile.lock"
RUN bundle install
COPY . "$APP_PATH"
EXPOSE 3000

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]
