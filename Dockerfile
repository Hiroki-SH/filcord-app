FROM ruby:2.6.6

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/list/*
RUN apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/list/*
RUN apt-get install -y build-essential libpq-dev nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install -y yarn

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY . /myapp
