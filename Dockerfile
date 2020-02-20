FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev ruby-dev postgresql-client git bash libgeos-3.7.1 libgeos++-dev libgdal-dev libproj-dev
RUN mkdir /ze_challenge
WORKDIR /ze_challenge
COPY Gemfile /ze_challenge/Gemfile
COPY Gemfile.lock /ze_challenge/Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY . /ze_challenge
RUN touch /tmp/caching-dev.txt

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
